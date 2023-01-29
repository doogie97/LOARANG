//
//  MarketDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/29.
//

import RxSwift

final class MarketDetailViewController: UIViewController {
    private let viewModel: MarketDetailViewModelable
    
    init(viewModel: MarketDetailViewModelable) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let disposeBag = DisposeBag()
    private let marketDetailView = MarketDetailView()
    
    override func loadView() {
        super.loadView()
        self.view = marketDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        bindButton()
    }
    
    private func bindButton() {
        marketDetailView.closeButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.touchCloseButton()
            }
            .disposed(by: disposeBag)
        
        viewModel.dismissView
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
