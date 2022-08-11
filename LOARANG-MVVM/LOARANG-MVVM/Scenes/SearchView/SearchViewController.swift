//
//  SearchViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RxSwift

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
        searchView.userSearchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] in
                guard let name = self?.searchView.userSearchBar.text else {
                    return
                }
                
                self?.viewModel.touchSearchButton(name)
        })
        .disposed(by: disposeBag)
        
        viewModel.showUserInfo.bind(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            self.navigationController?.pushViewController(self.container.makeUserInfoViewController($0), animated: true)
        })
        .disposed(by: disposeBag)
        
        searchView.backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBackButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.popView.bind(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.showAlert.bind(onNext: { [weak self] in
            self?.showAlert(title: nil, message: $0)
        })
        .disposed(by: disposeBag)
        
        viewModel.startedLoading
            .bind(onNext: { [weak self] in
                self?.searchView.activityIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.finishedLoading
            .bind(onNext: { [weak self] in
                self?.searchView.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}
