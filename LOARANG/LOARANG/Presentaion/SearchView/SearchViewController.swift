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
        searchView.bannerView.rootViewController = self
    }
    
    private func bindView() {
        bindKeyboard()
        
        viewModel.recentUser.bind(to: searchView.recentUserView.recentUserTableView.rx
            .items(cellIdentifier: "\(RecentUserTVCell.self)", cellType: RecentUserTVCell.self)) { [weak self] index, recentUser, cell in
                cell.setCellContents(cellViewModel: self?.container.makeRecentUserCellViewModel(userInfo: recentUser),
                                     recentUser: self?.viewModel.recentUser.value[safe: index],
                                     viewModel: self?.viewModel,
                                     index: index)
            }
            .disposed(by: disposeBag)
        
        viewModel.recentUser
            .withUnretained(self)
            .bind(onNext: { owner, recentUsers in
                if recentUsers.isEmpty {
                    owner.searchView.recentUserView.isHidden = true
                } else {
                    owner.searchView.recentUserView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        searchView.recentUserView.recentUserTableView.rx.itemSelected
            .withUnretained(self)
            .bind(onNext: { owner, index in
                owner.viewModel.touchRecentUserCell(index.row)
            })
            .disposed(by: disposeBag)
        
        searchView.recentUserView.clearButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.viewModel.touchClearRecentUserButton()
            })
            .disposed(by: disposeBag)
        
        searchView.userSearchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] in
                guard let name = self?.searchView.userSearchBar.text else {
                    return
                }
                self?.view.endEditing(true)
                self?.viewModel.touchSearchButton(name)
        })
        .disposed(by: disposeBag)
        
        viewModel.showUserInfo.bind(onNext: { [weak self] in
            guard let userInfoVC = self?.container.makeUserInfoViewController($0, isSearching: true) else {
                return
            }
            self?.navigationController?.pushViewController(userInfoVC, animated: true)
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
    }
    
    private func bindKeyboard() {
            searchView.userSearchBar.inputAccessoryView = closeKeyboardToolbar()
            
            viewModel.hideKeyboard
                .withUnretained(self)
                .bind { owner, _ in
                    owner.view.endEditing(true)
                }
                .disposed(by: disposeBag)
        }
}
