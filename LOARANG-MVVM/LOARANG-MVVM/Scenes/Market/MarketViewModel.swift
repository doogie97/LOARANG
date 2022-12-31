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
    func touchSearchButton(itemName: String, category: String, `class`: String, grade: String, tier: String)
}

protocol MarketViewModelOutput {
    var categoryText: BehaviorRelay<String> { get }
    var classText: BehaviorRelay<String> { get }
    var gradeText: BehaviorRelay<String> { get }
    var tierText: BehaviorRelay<String> { get }
    var categories: BehaviorRelay<[MarketOptions.Category]> { get }
    var subOptionList: BehaviorRelay<[String]> { get }
    var selectedOptionText: String { get }
    var showSubOptionsTableView: PublishRelay<Void> { get }
    var hideSubOptionsTableView: PublishRelay<Void> { get }
}

protocol MarketViewModelable: MarketViewModelInput, MarketViewModelOutput {}

final class MarketViewModel: MarketViewModelable {
    private let networkManager: NetworkManagerable
    
    private var classes: [String] = ["전체 직업"]
    private var itemGrades: [String] = ["전체 등급"]
    private var itemTiers: [String] = ["전체 티어"]
    private var selectedOptionType: OptionType = .category
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    //MARK: - input
    func getMarketOptions() {
        Task {
            do {
                let marketOptions = try await networkManager.request(MarketOptionsAPI(), resultType: MarketOptions.self)
                categories.accept(marketOptions.categories)
                classes.append(contentsOf: marketOptions.classes)
                itemGrades.append(contentsOf: marketOptions.itemGrades)
                itemTiers.append(contentsOf: marketOptions.itemTiers.map { "\($0) 티어" })
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
        
        showSubOptionsTableView.accept(())
    }
    
    func selectOptionCell(_ index: Int) {
        guard let optionText = subOptionList.value[safe: index] else {
            return
        }
        switch selectedOptionType {
        case .category:
            return //일단 리턴
        case .class:
            classText.accept(optionText)
        case .grade:
            gradeText.accept(optionText)
        case .tier:
            tierText.accept(optionText)
        }
        
        hideSubOptionsTableView.accept(())
    }
    
    func touchSearchButton(itemName: String, category: String, `class`: String, grade: String, tier: String) {
        print(itemName)
        print(category)
        print(`class`)
        print(grade)
        print(tier)
    }
    
    //MARK: - output
    let categoryText = BehaviorRelay<String>(value: "카테고리를 선택해 주세요")//얘는 아마 다른 타입이지 않을까? 왜냐면 카테고리는 카테고리 코드가 있으니까
    let classText = BehaviorRelay<String>(value: "전체 직업")
    let gradeText = BehaviorRelay<String>(value: "전체 등급")
    let tierText = BehaviorRelay<String>(value: "전체 티어")
    let categories = BehaviorRelay<[MarketOptions.Category]>(value: [])
    let subOptionList = BehaviorRelay<[String]>(value: [])
    let showSubOptionsTableView = PublishRelay<Void>()
    let hideSubOptionsTableView = PublishRelay<Void>()
    
    var selectedOptionText: String {
        switch selectedOptionType {
        case .category:
            return "" //일단 리턴
        case .class:
            return classText.value
        case .grade:
            return gradeText.value
        case .tier:
            return tierText.value
        }
    }
}

extension MarketViewModel {
    enum OptionType: Int {
        case category = 0
        case `class`
        case grade
        case tier
    }
}
