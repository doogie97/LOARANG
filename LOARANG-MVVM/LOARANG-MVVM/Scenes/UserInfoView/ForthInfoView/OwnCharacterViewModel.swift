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
}

final class OwnCharacterViewModel: OwnCharacterViewModelable {
    private let disposeBag = DisposeBag()
    init(ownCharacterInfo: BehaviorRelay<OwnCharacterInfo?>) {
    }
    
        ownCharacterInfo.bind(onNext: { [weak self] in
            guard let ownCharacterInfo = $0 else {
                return
            }
        })
        .disposed(by: disposeBag)
    }
    
    //out
}
