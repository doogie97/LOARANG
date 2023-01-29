//
//  MarketViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

import RxSwift

final class MarketViewController: UIViewController {
    private let viewModel: MarketViewModelable
    private let container: Container
    
    init(viewModel: MarketViewModelable, container: Container ) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let marketView = MarketView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = marketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
    }
    
    private func bindView() {
        buttonTextBind()
        bindItemTableView()
        bindKeyboard()
        marketView.marketOptionView.categoryButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchOptionButton(buttonTag: owner.marketView.marketOptionView.categoryButton.tag)
            }
            .disposed(by: disposeBag)
        
        marketView.marketOptionView.classButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchOptionButton(buttonTag: owner.marketView.marketOptionView.classButton.tag)
            }
            .disposed(by: disposeBag)
        
        marketView.marketOptionView.gradeButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchOptionButton(buttonTag: owner.marketView.marketOptionView.gradeButton.tag)
            }
            .disposed(by: disposeBag)
        
        viewModel.showOptionsView
            .withUnretained(self)
            .bind { owner, optionType in
                switch optionType {
                case .category:
                    owner.marketView.showOptionView(view: owner.marketView.categoryOptionView)
                case .class, .grade:
                    owner.marketView.showOptionView(view: owner.marketView.subOptionsTableView)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.hideOptionView
            .withUnretained(self)
            .bind { owner, optionType in
                owner.hideOptionView(optionType)
            }
            .disposed(by: disposeBag)
        
        
        marketView.blurButtonView.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchBlurView()
            }
            .disposed(by: disposeBag)
        
        viewModel.categoryOptionList
            .bind(to: marketView.categoryOptionView.mainOptionTableView.rx.items(cellIdentifier: "\(OptionCell.self)", cellType: OptionCell.self)) { index, category, cell in
                cell.setCellContents(optionTitle: category.codeName ?? "")
            }
            .disposed(by: disposeBag)
        
        viewModel.categorySubOptionList
            .bind(to: marketView.categoryOptionView.subOptionTableView.rx.items(cellIdentifier: "\(OptionCell.self)", cellType: OptionCell.self)) { [weak self] index, category, cell in
                let seletedMainIndex = self?.marketView.categoryOptionView.mainOptionTableView.indexPathForSelectedRow?.row
                if self?.viewModel.categoryMainOptionIndex == seletedMainIndex,
                   category.codeName == self?.viewModel.selectedOptionText ?? "" {
                    cell.setSelectedCell()
                }
                cell.setCellContents(optionTitle: category.codeName ?? "")
            }
            .disposed(by: disposeBag)
        
        viewModel.subOptionList
            .bind(to: marketView.subOptionsTableView.rx.items(cellIdentifier: "\(OptionCell.self)", cellType: OptionCell.self)){ [weak self] index, title, cell in
                if title == self?.viewModel.selectedOptionText ?? "" {
                    cell.setSelectedCell()
                }
                cell.setCellContents(optionTitle: title)
            }
            .disposed(by: disposeBag)
        
        marketView.categoryOptionView.mainOptionTableView.rx.itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                owner.viewModel.selectOptionCell(indexPath.row)
            }
            .disposed(by: disposeBag)
        
        marketView.categoryOptionView.subOptionTableView.rx.itemSelected
            .withUnretained(self)
            .bind { [weak self] owner, indexPath in
                let mainIndex = self?.marketView.categoryOptionView.mainOptionTableView.indexPathForSelectedRow?.row
                
                owner.viewModel.selectCategorySubOption(mainIndex: mainIndex ?? 0,
                                                        subIndex: indexPath.row)
            }
            .disposed(by: disposeBag)
        
        marketView.subOptionsTableView.rx.itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                owner.viewModel.selectOptionCell(indexPath.row)
            }
            .disposed(by: disposeBag)
        
        marketView.marketOptionView.itemSearchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .withUnretained(self)
            .bind { owner, _ in
                owner.touchSearchButton()
            }
            .disposed(by: disposeBag)
        
        marketView.marketOptionView.searchButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.touchSearchButton()
            }
            .disposed(by: disposeBag)
        
        viewModel.showAlert
            .withUnretained(self)
            .bind { owner, message in
                owner.showAlert(message: message)
            }
            .disposed(by: disposeBag)
    }

    private func buttonTextBind() {
        viewModel.categoryText
            .withUnretained(self)
            .bind { owner, text in
                owner.marketView.marketOptionView.categoryButton.setTitle(text, for: .normal)
            }
            .disposed(by: disposeBag)
        
        viewModel.classText
            .withUnretained(self)
            .bind { owner, text in
                owner.marketView.marketOptionView.classButton.setTitle(text, for: .normal)
            }
            .disposed(by: disposeBag)
        
        viewModel.gradeText
            .withUnretained(self)
            .bind { owner, text in
                owner.marketView.marketOptionView.gradeButton.setTitle(text, for: .normal)
            }
            .disposed(by: disposeBag)
        
        viewModel.optionButtonActivation
            .withUnretained(self)
            .bind { owner, buttonType in
                owner.marketView.marketOptionView.setButtonActivation(buttonType)
            }
            .disposed(by: disposeBag)
    }
    
    private func hideOptionView(_ optionType: MarketViewModel.OptionType) {
        switch optionType {
        case .category:
            marketView.hideOptionView(view: marketView.categoryOptionView)
            marketView.categoryOptionView.mainOptionTableView
                .selectRow(at: IndexPath(row: viewModel.categoryMainOptionIndex,
                                         section: 0), animated: false,
                           scrollPosition: .none)

        case .class, .grade:
            marketView.hideOptionView(view: marketView.subOptionsTableView)
        }
    }
    
    private func touchSearchButton() {
        viewModel.touchSearchButton(itemName: marketView.marketOptionView.itemSearchBar.text ?? "",
                                    class: marketView.marketOptionView.classButton.titleLabel?.text ?? "",
                                    grade: marketView.marketOptionView.gradeButton.titleLabel?.text ?? "")
    }
    
    private func bindItemTableView() {
        viewModel.marketItems
            .withUnretained(self)
            .bind { owner, items in
                owner.marketView.noItemLabel.isHidden = !items.isEmpty
            }
            .disposed(by: disposeBag)
        
        
        viewModel.marketItems
            .bind(to: marketView.marketItemListView.marketItemTableView.rx.items(cellIdentifier: "\(MarketItemCell.self)", cellType: MarketItemCell.self)) { index, item, cell in
                cell.setCellContents(item)
            }
            .disposed(by: disposeBag)
        
        marketView.marketItemListView.marketItemTableView.rx.prefetchRows
            .withUnretained(self)
            .bind { owner, indexPath in
                let itemCount = owner.viewModel.marketItems.value.count
                
                if indexPath.last?.row == itemCount - 1 {
                    owner.viewModel.scrolledEndPoint()
                }
            }
            .disposed(by: disposeBag)
        
        marketView.marketItemListView.marketItemTableView.rx.itemSelected
            .withUnretained(self)
            .bind { owner, indexPath in
                owner.viewModel.touchItemCell(indexPath.row)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindKeyboard() {
        marketView.marketOptionView.itemSearchBar.inputAccessoryView = closeKeyboardToolbar()
        
        viewModel.hideKeyboard
            .withUnretained(self)
            .bind { (owner, _) in
                owner.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}
