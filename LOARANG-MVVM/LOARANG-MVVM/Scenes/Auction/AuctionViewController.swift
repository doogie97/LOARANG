//
//  AuctionViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/29.
//

import RxSwift

final class AuctionViewController: UIViewController {
    private let viewModel: AuctionViewModelable
    private let container: Container
    
    init(viewModel: AuctionViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let auctionView = AuctionView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = auctionView
    }
}
