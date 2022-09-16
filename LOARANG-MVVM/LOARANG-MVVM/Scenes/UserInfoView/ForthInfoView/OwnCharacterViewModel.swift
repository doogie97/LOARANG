//
//  OwnCharacterViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/16.
//

import RxRelay
import RxSwift

protocol OwnCharacterViewModelable: OwnCharacterViewModelInput, OwnCharacterViewModelOutput {}

protocol OwnCharacterViewModelInput {}

protocol OwnCharacterViewModelOutput {
    var ownCharacterInfo: BehaviorRelay<OwnCharacterInfo?> { get }
    var ownCharacters: BehaviorRelay<[OwnCharacter]> { get }
}

final class OwnCharacterViewModel: OwnCharacterViewModelable {
    private let disposeBag = DisposeBag()
    init(ownCharacterInfo: BehaviorRelay<OwnCharacterInfo?>) {
        self.ownCharacterInfo = ownCharacterInfo
        bind()
    }
    
    private func bind() {
        ownCharacterInfo.bind(onNext: { [weak self] in
            guard let ownCharacterInfo = $0 else {
                return
            }
            self?.ownCharacters.accept(ownCharacterInfo.ownCharacters)
        })
        .disposed(by: disposeBag)
    }
    
    //out
    let ownCharacterInfo: BehaviorRelay<OwnCharacterInfo?>
    let ownCharacters = BehaviorRelay<[OwnCharacter]>(value: [])
}
