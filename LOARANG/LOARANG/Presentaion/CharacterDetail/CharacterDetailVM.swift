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
    var popView: PublishRelay<Void> { get }
    var showNextView: PublishRelay<CharacterDetailVM.NextViewCase> { get }
}

final class CharacterDetailVM: CharacterDetailVMable {
    private let characterName: String
    private var isBookmark = false {
        didSet {
            changeBookmarkButton.accept(isBookmark)
        }
    }
    private var characterInfo: CharacterDetailEntity? 
    
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    init(characterName: String, getCharacterDetailUseCase: GetCharacterDetailUseCase) {
        self.characterName = characterName
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
    }
    //MARK: - Input
    func viewDidLoad() {
        getCharacterDetail()
    }
    
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchBookmarkButton() {
        isBookmark = !self.isBookmark
    }
    
    private func getCharacterDetail() {
        isLoading.accept(true)
        Task {
            do {
                self.characterInfo = try await getCharacterDetailUseCase.excute(name: characterName)
                await MainActor.run {
                    setViewContents.accept(())
                    isLoading.accept(false)
                }
            } catch let error {
                await MainActor.run {
                    print(error.errorMessage)
                    isLoading.accept(false)
                }
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
    let popView = PublishRelay<Void>()
    let showNextView = PublishRelay<NextViewCase>()
}
