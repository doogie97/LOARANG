//
//  ViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RxSwift

final class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    private let container: Container
    
    init(viewModel: MainViewModel, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        bindView()
    }
    
    private func bindView() {
        //SearchButton
        mainView.searchButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSerachButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.showSearchView.bind(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            self.navigationController?.pushViewController(self.container.makeSearchViewController(), animated: true)
        })
        .disposed(by: disposeBag)
        
        //ShowUserInfo
        viewModel.showUserInfo
            .bind(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.navigationController?
                    .pushViewController(self.container.makeUserInfoViewController($0), animated: true)
            })
            .disposed(by: disposeBag)

        // MainView contents
        viewModel.mainUser
            .bind(onNext: { [weak self] in
                self?.mainView.mainUserView.setUserInfo($0)
            })
            .disposed(by: disposeBag)
        
        mainView.mainUserView.rx.tapGesture().when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.viewModel.touchMainUser()
            })
            .disposed(by: disposeBag)
        
        // BookmarkView contents
        viewModel.bookmarkUser.bind(to: mainView.bookmarkView.bookMarkCollectionView.rx.items(cellIdentifier: "\(BookmarkCVCell.self)", cellType: BookmarkCVCell.self)) { [weak self] index, bookmark, cell in
            cell.setCell(bookmark, viewModel: self?.container.makeBookmarkCVCellViewModel())
        }
        .disposed(by: disposeBag)
        
        viewModel.bookmarkUser
            .bind(onNext: { [weak self] in
                self?.mainView.bookmarkView.setViewContents(bookmarkCount: $0.count)
            })
            .disposed(by: disposeBag)
        
        mainView.bookmarkView.bookMarkCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBookMarkCell($0.row)
            })
            .disposed(by: disposeBag)
    }
}
