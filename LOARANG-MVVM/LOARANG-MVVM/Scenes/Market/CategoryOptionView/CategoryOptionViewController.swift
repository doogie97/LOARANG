//
//  CategoryOptionViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import RxSwift

final class CategoryOptionViewController: UIViewController {
    private let viewModel: CategoryOptionViewModelable
    
    init(viewModel: CategoryOptionViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let categoryOptionView = CategoryOptionView()
    
    override func loadView() {
        super.loadView()
        self.view = categoryOptionView
    }
}