//
//  CharacterDetailVM.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import RxRelay

protocol CharacterDetailVMable: CharacterDetailVMInput, CharacterDetailVMOutput, AnyObject {}
protocol CharacterDetailVMInput {
    func viewDidLoad()
    func touchBackButton()
    func touchBookmarkButton()
    func touchSkillCell(_ index: Int)
}

protocol CharacterDetailVMOutput {
    var characterInfoData: CharacterDetailEntity? { get }
    var isLoading: PublishRelay<Bool> { get }
    var setViewContents: PublishRelay<Void> { get }
    var changeBookmarkButton: PublishRelay<Bool> { get }
    var showAlert: PublishRelay<(message: String, isPop: Bool)> { get }
    var popView: PublishRelay<Void> { get }
    var showNextView: PublishRelay<CharacterDetailVM.NextViewCase> { get }
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
    
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    private let addBookmarkUseCase: AddBookmarkUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    private let updateBookmarkUseCase: UpdateBookmarkUseCase
    
    init(characterName: String,
         isSearch: Bool,
         getCharacterDetailUseCase: GetCharacterDetailUseCase,
         addBookmarkUseCase: AddBookmarkUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase,
         updateBookmarkUseCase: UpdateBookmarkUseCase) {
        self.characterName = characterName
        self.isSearch = isSearch
        self.isBookmark = characterName.isBookmark
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.addBookmarkUseCase = addBookmarkUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        self.updateBookmarkUseCase = updateBookmarkUseCase
        
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
    
    private func getCharacterDetail() {
        isLoading.accept(true)
        Task {
            do {
                let characterEntity = try await getCharacterDetailUseCase.excute(name: characterName)
                self.characterInfo = characterEntity
                await MainActor.run {
                    setViewContents.accept(())
                    bookmarkUpdate(characterEntity)
                    isLoading.accept(false)
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept((message: error.errorMessage, isPop: true))
                    isLoading.accept(false)
                }
            }
        }
    }
    
    private func bookmarkUpdate(_ character: CharacterDetailEntity) {
        if ViewChangeManager.shared.bookmarkUsers.value.contains(where: { $0.name == character.profile.characterName }) {
            do {
                try updateBookmarkUseCase.execute(user: BookmarkUserEntity(name: character.profile.characterName,
                                                                           imageUrl: character.profile.imageUrl,
                                                                           characterClass: character.profile.characterClass))
            } catch let error {
                showAlert.accept((message: error.errorMessage, isPop: false))
            }
        }
    }
    
    func touchSkillCell(_ index: Int) {
        guard let skill = characterInfo?.skillInfo.skills[safe: index] else {
            return
        }
        
        showNextView.accept(.skillDetail(skill: skill))
    }
    
    //MARK: - Output
    var characterInfoData: CharacterDetailEntity? {
        return self.characterInfo
    }
    
    enum NextViewCase {
        case skillDetail(skill: Skill)
    }
    
    let isLoading = PublishRelay<Bool>()
    let setViewContents = PublishRelay<Void>()
    let changeBookmarkButton = PublishRelay<Bool>()
    let showAlert = PublishRelay<(message: String, isPop: Bool)>()
    let popView = PublishRelay<Void>()
    let showNextView = PublishRelay<NextViewCase>()
}
