//
//  MarketViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

import RxRelay

protocol MarketViewModelInput {
    func getMarketOptions()
    func touchOptionButton(buttonTag: Int)
    func selectOptionCell(_ index: Int)
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
    private var selectedOptionType: OptionType = .category
    
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
                itemTiers = marketOptions.itemTiers.map { "\($0) 티어" }
            } catch {
                print("거래소 옵션을 불러올 수 없습니다") // 추후 얼럿으로 변경
            }
        }
    }
    
    func touchOptionButton(buttonTag: Int) {
        guard let optionType = OptionType(rawValue: buttonTag) else {
            return
        }
        
        self.selectedOptionType = optionType
        
        switch optionType {
        case .category:
            print("touch category button")
            return //일단 리턴 시키고 추 후에 기능 구현 예정
        case .class:
            subOptionList.accept(classes)
        case .grade:
            subOptionList.accept(itemGrades)
        case .tier:
            subOptionList.accept(itemTiers)
        }
        
        showSubOptionsView.accept(())
    }
    
    func selectOptionCell(_ index: Int) {
        print(selectedOptionType)
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
