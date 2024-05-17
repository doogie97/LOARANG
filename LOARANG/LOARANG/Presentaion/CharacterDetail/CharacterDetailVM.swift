//
//  CharacterDetailVM.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import RxRelay
import UIKit
import Mixpanel

protocol CharacterDetailVMable: CharacterDetailVMInput, CharacterDetailVMOutput, AnyObject {}
protocol CharacterDetailVMInput {
    func viewDidLoad()
    func touchBackButton()
    func touchBookmarkButton()
    func touchMoveHomeButton()
    func touchGem()
    func touchSkillCell(_ index: Int)
    func touchOwnCharacterCell(_ indexPath: IndexPath)
    func touchShareImageButton(_ image: UIImage)
}

protocol CharacterDetailVMOutput {
    var characterInfoData: CharacterDetailEntity? { get }
    var ownCharactersInfoData: [OwnCharactersEntity.ServerInfo] { get }
    var isLoading: PublishRelay<Bool> { get }
    var setViewContents: PublishRelay<Void> { get }
    var changeBookmarkButton: PublishRelay<Bool> { get }
    var showAlert: PublishRelay<(message: String, isPop: Bool)> { get }
    var popView: PublishRelay<Void> { get }
    var showNextView: PublishRelay<CharacterDetailVM.NextViewCase> { get }
    var popToHome: PublishRelay<Void> { get }
}

final class CharacterDetailVM: CharacterDetailVMable {
    private let characterName: String
    private let isSearch: Bool
    private var isBookmark: Bool {
        didSet {
            changeBookmarkButton.accept(isBookmark)
        }
    }
    private var characterInfo: CharacterDetailEntity? 
    private var ownCharactersInfo = [OwnCharactersEntity.ServerInfo]()
    
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    private let getOwnCharactersUseCase: GetOwnCharactersUseCase
    private let changeMainUserUseCase: ChangeMainUserUseCase
    private let addBookmarkUseCase: AddBookmarkUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    private let updateBookmarkUseCase: UpdateBookmarkUseCase
    private let addRecentUserUseCase: AddRecentUserUseCase
    
    init(characterName: String,
         isSearch: Bool,
         getCharacterDetailUseCase: GetCharacterDetailUseCase,
         getOwnCharactersUseCase: GetOwnCharactersUseCase,
         changeMainUserUseCase: ChangeMainUserUseCase,
         addBookmarkUseCase: AddBookmarkUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase,
         updateBookmarkUseCase: UpdateBookmarkUseCase,
         addRecentUserUseCase: AddRecentUserUseCase) {
        self.characterName = characterName
        self.isSearch = isSearch
        self.isBookmark = characterName.isBookmark
        
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.getOwnCharactersUseCase = getOwnCharactersUseCase
        self.changeMainUserUseCase = changeMainUserUseCase
        self.addBookmarkUseCase = addBookmarkUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        self.updateBookmarkUseCase = updateBookmarkUseCase
        self.addRecentUserUseCase = addRecentUserUseCase
        
    }
    //MARK: - Input
    func viewDidLoad() {
        getCharacterDetail()
    }
    
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchBookmarkButton() {
        do {
            if isBookmark {
                try deleteBookmarkUseCase.execute(name: characterName)
            } else {
                try addBookmarkUseCase.execute(
                    user: BookmarkUserEntity(name: characterName,
                                             imageUrl: characterInfoData?.profile.imageUrl ?? "",
                                             characterClass: characterInfoData?.profile.characterClass ?? .unknown)
                )
            }
            
            isBookmark = !self.isBookmark
        } catch let error {
            showAlert.accept((message: error.errorMessage, isPop: false))
        }
    }
    
    func touchMoveHomeButton() {
        popToHome.accept(())
    }
    
    private func getCharacterDetail() {
        isLoading.accept(true)
        Task {
            do {
                let characterEntity = try await getCharacterDetailUseCase.excute(name: characterName)
                let ownCharacterEntity = try await getOwnCharactersUseCase.execute(name: characterName)
                self.characterInfo = characterEntity
                self.ownCharactersInfo = ownCharacterEntity.serverList
                await MainActor.run {
                    setViewContents.accept(())
                    localStorageUpdate(characterEntity)
                    Mixpanel.mainInstance().track(
                        event: "SearchCharacter",
                        properties: ["characterName" : characterName]
                    )
                    isLoading.accept(false)
                }
            } catch {
                await MainActor.run {
                    showAlert.accept((message: "캐릭터 정보를 찾을 수 없습니다.\n캐릭터명을 다시 한 번 확인해 주세요!", isPop: true))
                    isLoading.accept(false)
                }
            }
        }
    }
    
    private func localStorageUpdate(_ character: CharacterDetailEntity) {
        do {
            if character.profile.characterName.isBookmark {
                try updateBookmarkUseCase.execute(user: BookmarkUserEntity(name: character.profile.characterName,
                                                                           imageUrl: character.profile.imageUrl,
                                                                           characterClass: character.profile.characterClass))
            }
            if character.profile.characterName.isMainUser {
                try changeMainUserUseCase.execute(user: MainUserEntity(
                    imageUrl: character.profile.imageUrl,
                    battleLV: character.profile.battleLevel,
                    name: character.profile.characterName,
                    characterClass: character.profile.characterClass,
                    itemLV: character.profile.itemLevel,
                    expeditionLV: character.profile.expeditionLevel,
                    gameServer: character.profile.gameServer
                ))
            }
            if isSearch {
                try addRecentUserUseCase.execute(user: RecentUserEntity(name: character.profile.characterName,
                                                                        imageUrl: character.profile.imageUrl,
                                                                        characterClass: character.profile.characterClass))
            }
        } catch let error {
            showAlert.accept((message: error.errorMessage, isPop: false))
        }
    }
    
    func touchGem() {
        showNextView.accept(.gemDetail)
    }
    
    func touchSkillCell(_ index: Int) {
        guard let skill = characterInfo?.skillInfo.skills[safe: index] else {
            return
        }
        
        showNextView.accept(.skillDetail(skill: skill))
    }
    
    func touchOwnCharacterCell(_ indexPath: IndexPath) {
        guard let name = ownCharactersInfo[safe: indexPath.section]?.characters[safe: indexPath.row]?.characterName else {
            return
        }
        
        if name == self.characterName {
            showNextView.accept(.selectFirstTab)
        } else {
            showNextView.accept(.characterDetail(name: name))
        }
    }
    
    func touchShareImageButton(_ image: UIImage) {
        showNextView.accept(.shareImage(image: image))
    }
    
    //MARK: - Output
    var characterInfoData: CharacterDetailEntity? {
        return self.characterInfo
    }
    
    var ownCharactersInfoData: [OwnCharactersEntity.ServerInfo] {
        return self.ownCharactersInfo
    }
    
    enum NextViewCase {
        case skillDetail(skill: Skill)
        case characterDetail(name: String)
        case selectFirstTab
        case gemDetail
        case shareImage(image: UIImage)
    }
    
    let isLoading = PublishRelay<Bool>()
    let setViewContents = PublishRelay<Void>()
    let changeBookmarkButton = PublishRelay<Bool>()
    let showAlert = PublishRelay<(message: String, isPop: Bool)>()
    let popView = PublishRelay<Void>()
    let showNextView = PublishRelay<NextViewCase>()
    let popToHome = PublishRelay<Void>()
}
