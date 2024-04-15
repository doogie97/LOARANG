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
}
protocol CharacterDetailVMOutput {
    var isLoading: PublishRelay<Bool> { get }
    var setViewContents: PublishRelay<CharacterDetailVM.ViewContents> { get }
}

final class CharacterDetailVM: CharacterDetailVMable {
    private let characterName: String
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    init(characterName: String, getCharacterDetailUseCase: GetCharacterDetailUseCase) {
        self.characterName = characterName
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
    }
    //MARK: - Input
    func viewDidLoad() {
        setViewContents.accept(ViewContents(viewModel: self))
    }
    
    //MARK: - Output
    struct ViewContents {
        weak var viewModel: CharacterDetailVMable?
    }
    
    let isLoading = PublishRelay<Bool>()
    let setViewContents = PublishRelay<ViewContents>()
}
