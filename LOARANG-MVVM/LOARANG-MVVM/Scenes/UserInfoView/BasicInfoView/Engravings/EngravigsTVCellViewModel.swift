//
//  EngravigsTVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import RxRelay

protocol EngravigsTVCellViewModelable: EngravigsTVCellViewModelInput, EngravigsTVCellViewModelOutput {}

protocol EngravigsTVCellViewModelInput {}

protocol EngravigsTVCellViewModelOutput {
    var engravings: BehaviorRelay<[Engraving]> { get }
}

final class EngravigsTVCellViewModel: EngravigsTVCellViewModelable {
    init(engravings: [Engraving]) {
        self.engravings = BehaviorRelay<[Engraving]>(value: engravings)
    }
    
    let engravings: BehaviorRelay<[Engraving]>
}
