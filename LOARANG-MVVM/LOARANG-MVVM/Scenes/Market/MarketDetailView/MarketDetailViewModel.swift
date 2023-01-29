//
//  MarketDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/29.
//

import RxRelay

protocol MarketDetailViewModelable: MarketDetailViewModelInput, MarketDetailViewModelOutput {}

protocol MarketDetailViewModelInput {
    func touchCloseButton()
}

protocol MarketDetailViewModelOutput {
    var dismissView: PublishRelay<Void> { get }
}

final class MarketDetailViewModel: MarketDetailViewModelable {
    private let item: MarketItems.Item
    
    init(item: MarketItems.Item) {
        self.item = item
    }
    
    //MARK: - In
    func touchCloseButton() {
        dismissView.accept(())
    }
    
    //MARK: - Out
    let dismissView = PublishRelay<Void>()
}
