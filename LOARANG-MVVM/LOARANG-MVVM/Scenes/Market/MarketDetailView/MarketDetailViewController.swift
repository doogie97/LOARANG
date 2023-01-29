//
//  MarketDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/29.
//

import UIKit

final class MarketDetailViewController: UIViewController {
    private let viewModel: MarketDetailViewModelable
    
    init(viewModel: MarketDetailViewModelable) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let marketDetailView = MarketDetailView()
    
    override func loadView() {
        super.loadView()
        self.view = marketDetailView
    }
}
