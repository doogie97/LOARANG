//
//  CategoryOptionView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import RxRelay

protocol CategoryOptionViewModelInput {}

protocol CategoryOptionViewModelOutput {
    var mainOptionsTitle: BehaviorRelay<[String]> { get }
}

protocol CategoryOptionViewModelable: CategoryOptionViewModelInput, CategoryOptionViewModelOutput {}

final class CategoryOptionViewModel: CategoryOptionViewModelable {
    let options: [MarketOptions.Category]
    
    init(options: [MarketOptions.Category]) {
        self.options = options
        mainOptionsTitle.accept(options.map { $0.codeName ?? "" })
    }
    
    //MARK: - out
    let options: BehaviorRelay<[MarketOptions.Category]>
    //MARK: - output
    let mainOptionsTitle = BehaviorRelay<[String]>(value: [])
}
