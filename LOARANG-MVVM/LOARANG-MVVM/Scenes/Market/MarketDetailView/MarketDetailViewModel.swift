//
//  MarketDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/29.
//

protocol MarketDetailViewModelable: MarketDetailViewModelInput, MarketDetailViewModelOutput {}

protocol MarketDetailViewModelInput {}

protocol MarketDetailViewModelOutput {}

final class MarketDetailViewModel: MarketDetailViewModelable {
    private let item: MarketItems.Item
    
    init(item: MarketItems.Item) {
        self.item = item
    }
}
