//
//  MarketViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

protocol MarketViewModelInput {
    func touchCategoryButton()
}

protocol MarketViewModelOutput {}

protocol MarketViewModelable: MarketViewModelInput, MarketViewModelOutput {}

final class MarketViewModel: MarketViewModelable {
    private let networkManager: NetworkManagerable
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager

    }
    
    func touchCategoryButton() {
        print("touch category button")
    }
}
