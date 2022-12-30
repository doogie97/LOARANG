//
//  MarketViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

import RxRelay

protocol MarketViewModelInput {
    func getMarketOptions()
    func touchCategoryButton()
}

protocol MarketViewModelOutput {
    var categories: BehaviorRelay<[MarketOptions.Category]> { get }
    var classes: BehaviorRelay<[String]> { get }
    var itemGrades: BehaviorRelay<[String]> { get }
    var itemTiers: BehaviorRelay<[Int]> { get }
}

protocol MarketViewModelable: MarketViewModelInput, MarketViewModelOutput {}

final class MarketViewModel: MarketViewModelable {
    private let networkManager: NetworkManagerable
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
        
    }
    
    func getMarketOptions() {
        Task {
            do {
                let marketOptions = try await networkManager.request(MarketOptionsAPI(), resultType: MarketOptions.self)
                categories.accept(marketOptions.categories)
                classes.accept(marketOptions.classes)
                itemGrades.accept(marketOptions.itemGrades)
                itemTiers.accept(marketOptions.itemTiers)
            } catch {
                print("거래소 옵션을 불러올 수 없습니다") // 추후 얼럿으로 변경
            }
        }
    }
    
    func touchCategoryButton() {
        print("touch category button")
    }
    
    //MARK: - out
    let categories = BehaviorRelay<[MarketOptions.Category]>(value: [])
    let classes = BehaviorRelay<[String]>(value: [])
    let itemGrades = BehaviorRelay<[String]>(value: [])
    let itemTiers = BehaviorRelay<[Int]>(value: [])
}
