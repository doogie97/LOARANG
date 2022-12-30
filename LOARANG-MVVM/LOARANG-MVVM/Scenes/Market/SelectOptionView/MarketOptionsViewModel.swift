//
//  MarketOptionsViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import RxRelay

protocol MarketOptionsViewModelInput {}

protocol MarketOptionsViewModelOutput {
    var options: BehaviorRelay<[String]> { get }
}

protocol MarketOptionsViewModelable: MarketOptionsViewModelInput, MarketOptionsViewModelOutput {}

final class MarketOptionsViewModel: MarketOptionsViewModelable {
    init(options: BehaviorRelay<[String]>) {
        self.options = options
    }
    
    //MARK: - out
    let options: BehaviorRelay<[String]>
}
