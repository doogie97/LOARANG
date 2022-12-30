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
    func touchClassButton()
    func touchGradeButton()
    func touchTierButton()
}

protocol MarketViewModelOutput {
    var categories: BehaviorRelay<[MarketOptions.Category]> { get }
    var subOptionList: BehaviorRelay<[String]> { get }
    var showSubOptionsView: PublishRelay<Void> { get }
}

protocol MarketViewModelable: MarketViewModelInput, MarketViewModelOutput {}

final class MarketViewModel: MarketViewModelable {
    private let networkManager: NetworkManagerable
    
    private var classes: [String] = []
    private var itemGrades: [String] = []
    private var itemTiers: [String] = []
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func getMarketOptions() {
        Task {
            do {
                let marketOptions = try await networkManager.request(MarketOptionsAPI(), resultType: MarketOptions.self)
                categories.accept(marketOptions.categories)
                classes = marketOptions.classes
                itemGrades = marketOptions.itemGrades
                itemTiers = marketOptions.itemTiers.map { $0.description }
            } catch {
                print("거래소 옵션을 불러올 수 없습니다") // 추후 얼럿으로 변경
            }
        }
    }
    
    func touchCategoryButton() {
        print("touch category button")
    }
    
    func touchClassButton() {
        subOptionList.accept(classes)
    }
    
    func touchGradeButton() {
        subOptionList.accept(itemGrades)
    }
    
    func touchTierButton() {
        subOptionList.accept(itemTiers)
    }
    
    //MARK: - out
    let categories = BehaviorRelay<[MarketOptions.Category]>(value: [])
    let subOptionList = BehaviorRelay<[String]>(value: [])
    let showSubOptionsView = PublishRelay<Void>()
}

extension MarketViewModel {
    enum OptionType: Int {
        case category = 0
        case `class`
        case grade
        case tier
    }
}
