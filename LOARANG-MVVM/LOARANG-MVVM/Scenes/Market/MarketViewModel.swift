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
    func selectCategorySubOption(_ index: Int)
    func touchBlurView()
    func touchSearchButton(itemName: String, `class`: String, grade: String, tier: String)
}

protocol MarketViewModelOutput {
    var categoryText: BehaviorRelay<String> { get }
    var classText: BehaviorRelay<String> { get }
    var gradeText: BehaviorRelay<String> { get }
    var tierText: BehaviorRelay<String> { get }
    var categoryOptionList: BehaviorRelay<[MarketOptions.Category]> { get }
    var categorySubOptionList: BehaviorRelay<[MarketOptions.Category.Sub]> { get }
    var subOptionList: BehaviorRelay<[String]> { get }
    var selectedOptionText: String { get }
    var showOptionsView: PublishRelay<MarketViewModel.OptionType> { get }
    var hideOptionView: PublishRelay<MarketViewModel.OptionType> { get }
}

protocol MarketViewModelable: MarketViewModelInput, MarketViewModelOutput {}

final class MarketViewModel: MarketViewModelable {
    private let networkManager: NetworkManagerable
    
    private var categories: [MarketOptions.Category] = []
    private var classes: [String] = ["전체 직업"]
    private var itemGrades: [String] = ["전체 등급"]
    private var itemTiers: [String] = ["전체 티어"]
    private var selectedOptionType: OptionType = .category
    
    private var categoryMainOptionIndex = 0
    private var categorySubOptionIndex = 0
    
    private var searchOption: SearchMarketItemsAPI.SearchOption?
    private var pageNo = 1
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    //MARK: - input
    func getMarketOptions() {
        Task {
            do {
                let marketOptions = try await networkManager.request(MarketOptionsAPI(), resultType: MarketOptions.self)
                categories = marketOptions.categories
                categoryOptionList.accept(categories)
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
            acceptCategorySubOption()
        case .class:
            subOptionList.accept(classes)
        case .grade:
            subOptionList.accept(itemGrades)
        case .tier:
            subOptionList.accept(itemTiers)
        }
        
        showOptionsView.accept(self.selectedOptionType)
    }
    
    func selectOptionCell(_ index: Int) {
        switch selectedOptionType {
        case .category:
            categoryMainOptionIndex = index
            acceptCategorySubOption()
            return
        case .class:
            classText.accept(subOptionList.value[safe: index] ?? "")
        case .grade:
            gradeText.accept(subOptionList.value[safe: index] ?? "")
        case .tier:
            tierText.accept(subOptionList.value[safe: index] ?? "")
        }
        
        hideOptionView.accept(self.selectedOptionType)
    }
    
    func selectCategorySubOption(_ index: Int) {
        categorySubOptionIndex = index
        categoryText.accept(categoryCodeSet(index: index).codeName)
        
        hideOptionView.accept(self.selectedOptionType)
    }
    
    func touchBlurView() {
        hideOptionView.accept(self.selectedOptionType)
    }
    
    func touchSearchButton(itemName: String, `class`: String, grade: String, tier: String) {
        let categoryCode = categoryCodeSet(index: categorySubOptionIndex).code

        searchOption = SearchMarketItemsAPI.SearchOption(sort: .recentPrice,
                                                         categoryCode: categoryCode,
                                                         characterClass: `class`,
                                                         itemTier: checkItemTier(tier),
                                                         itemGrade: grade == "전체 등급" ? "" : grade,
                                                         itemName: itemName,
                                                         pageNo: pageNo,
                                                         sortCondition: .asc)
        searchItem()
    }
    
    private func acceptCategorySubOption() {
        let all = MarketOptions.Category.Sub(code: categories[safe: categoryMainOptionIndex]?.code,
                                             codeName: "전체")
        categorySubOptionList.accept([all] + (categories[safe: categoryMainOptionIndex]?.subs ?? []))
    }
    
    private func categoryCodeSet(index: Int) -> (code: Int, codeName: String) {
        let mainCategory = categories[safe: categoryMainOptionIndex]
        if index == 0 {
            return (code: mainCategory?.code ?? 0, codeName: (mainCategory?.codeName ?? "") + " - 전체")
        } else {
            let subCategory = mainCategory?.subs[safe: categorySubOptionIndex - 1]
            return (code: subCategory?.code ?? 0,
                    codeName: (mainCategory?.codeName ?? "") + " - " + (subCategory?.codeName ?? ""))
        }
    }
    
    private func checkItemTier(_ tierString: String) -> Int {
        switch tierString {
        case "1 티어":
            return 1
        case "2 티어":
            return 2
        case "3 티어":
            return 3
        default:
            return 0
        }
    }
    
    private func searchItem() {
        guard let searchOption = searchOption else {
            print("검색 설정 다시해달라 얼럿")
            return
        }
        Task {
            do {
                
                let searchAPI = SearchMarketItemsAPI(searchOption: searchOption)
                let response = try await networkManager.request(searchAPI, resultType: MarketItems.self)
                print(response.items.first?.name)
            } catch let error{
                print(error.errorMessage)
                print("검색 에러 얼럿")
            }
        }
    }
    
    //MARK: - output
    let categoryText = BehaviorRelay<String>(value: "카테고리를 선택해 주세요")
    let classText = BehaviorRelay<String>(value: "전체 직업")
    let gradeText = BehaviorRelay<String>(value: "전체 등급")
    let tierText = BehaviorRelay<String>(value: "전체 티어")
    let categoryOptionList = BehaviorRelay<[MarketOptions.Category]>(value: [])
    let categorySubOptionList = BehaviorRelay<[MarketOptions.Category.Sub]>(value: [])
    let subOptionList = BehaviorRelay<[String]>(value: [])
    let showOptionsView = PublishRelay<OptionType>()
    let hideOptionView = PublishRelay<OptionType>()
    
    var selectedOptionText: String {
        switch selectedOptionType {
        case .category:
            guard let subOptionText = categoryText.value.components(separatedBy: " - ")[safe: 1] else {
                return ""
            }
            return subOptionText
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
