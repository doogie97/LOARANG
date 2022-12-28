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
}
