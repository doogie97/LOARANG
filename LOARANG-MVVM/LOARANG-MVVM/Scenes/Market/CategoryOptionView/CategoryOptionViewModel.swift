//
//  CategoryOptionView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import RxRelay

protocol CategoryOptionViewModelInput {}

protocol CategoryOptionViewModelOutput {
    var options: BehaviorRelay<[MarketOptions.Category]> { get }
}

protocol CategoryOptionViewModelable: CategoryOptionViewModelInput, CategoryOptionViewModelOutput {}

final class CategoryOptionViewModel: CategoryOptionViewModelable {
    init(options: [MarketOptions.Category]) {
        self.options = BehaviorRelay<[MarketOptions.Category]>(value: options)
    }
    
    //MARK: - out
    let options: BehaviorRelay<[MarketOptions.Category]>
}
