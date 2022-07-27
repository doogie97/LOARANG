//
//  SearchViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    private let viewModel: SearchViewModelable
    private let container: Container
    
    init(viewModel: SearchViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchView = SearchView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        searchView.backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBackButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.popView.bind(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        .disposed(by: disposeBag)
    }
}
