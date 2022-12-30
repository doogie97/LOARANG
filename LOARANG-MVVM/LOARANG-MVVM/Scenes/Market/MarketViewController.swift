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
        viewModel.getMarketOptions()
    }
    
    private func bindView() {
        marketView.categoryButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchOptionButton(buttonTag: owner.marketView.categoryButton.tag)
            }
            .disposed(by: disposeBag)
        
        marketView.classButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchOptionButton(buttonTag: owner.marketView.classButton.tag)
            }
            .disposed(by: disposeBag)
        
        marketView.gradeButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchOptionButton(buttonTag: owner.marketView.gradeButton.tag)
            }
            .disposed(by: disposeBag)
        
        marketView.tierButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchOptionButton(buttonTag: owner.marketView.tierButton.tag)
            }
            .disposed(by: disposeBag)
        
        viewModel.showSubOptionsView
            .withUnretained(self)
            .bind { owner, options in
                owner.marketView.showSubOptionsTableView()
            }
            .disposed(by: disposeBag)
        
        marketView.blurButtonView.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.marketView.hideSubOptionsTableView()
            }
            .disposed(by: disposeBag)
        
        viewModel.subOptionList
            .bind(to: marketView.subOptionsTableView.rx.items(cellIdentifier: "\(SubOptionCell.self)", cellType: SubOptionCell.self)){ index, title, cell in
                cell.setCellContents(optionTitle: title)
            }
            .disposed(by: disposeBag)
    }
}
