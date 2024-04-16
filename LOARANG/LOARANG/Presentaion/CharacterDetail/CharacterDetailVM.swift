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
    func touchSegment(_ index: Int)
}
protocol CharacterDetailVMOutput {
    var isLoading: PublishRelay<Bool> { get }
    var setViewContents: PublishRelay<CharacterDetailVM.ViewContents> { get }
    var changeBookmarkButton: PublishRelay<Bool> { get }
    var popView: PublishRelay<Void> { get }
}

final class CharacterDetailVM: CharacterDetailVMable {
    private let characterName: String
    private var isBookmark = false {
        didSet {
            changeBookmarkButton.accept(isBookmark)
        }
    }
    
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
                let character = try await getCharacterDetailUseCase.excute(name: characterName)
                await MainActor.run {
                    setViewContents.accept(ViewContents(viewModel: self,
                                                        character: character))
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
    
    func touchSegment(_ index: Int) {
        print(index)
    }
    
    //MARK: - Output
    struct ViewContents {
        weak var viewModel: CharacterDetailVMable?
        let character: CharacterDetailEntity
    }
    
    let isLoading = PublishRelay<Bool>()
    let setViewContents = PublishRelay<ViewContents>()
    let changeBookmarkButton = PublishRelay<Bool>()
    let popView = PublishRelay<Void>()
}
