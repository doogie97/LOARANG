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
            guard let searchVC = self?.container.makeSearchViewController() else {
                return
            }
            
            self?.navigationController?.pushViewController(searchVC, animated: true)
        })
        .disposed(by: disposeBag)
        
        //ShowUserInfo
        viewModel.showUserInfo
            .bind(onNext: { [weak self] in
                guard let userInfoVC = self?.container.makeUserInfoViewController($0) else {
                    return
                }
                self?.navigationController?.pushViewController(userInfoVC, animated: true)
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
        
        mainView.mainUserView.setMainUserButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.showSetMainCharacterAlert(action: {
                    self?.viewModel.touchMainUserSearchButton($0)
                })
            })
            .disposed(by: disposeBag)
        
        viewModel.startedLoading
            .bind(onNext: { [weak self] in
                self?.mainView.activityIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.finishedLoading
            .bind(onNext: { [weak self] in
                self?.mainView.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.showAlert
            .bind(onNext: { [weak self] in
                self?.showAlert(message: $0)
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
        
        // EventView contents
        viewModel.events.bind(to: mainView.eventView.eventCollectionView.rx.items(cellIdentifier: "\(EventCVCell.self)", cellType: EventCVCell.self)) { index, event, cell in
            cell.setCellContents(event)
        }
        .disposed(by: disposeBag)
        
        mainView.eventView.eventCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchEventCell($0.row)
            })
            .disposed(by: disposeBag)
        
        mainView.eventView.moreEventButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchMoreEventButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.showWebView
            .bind(onNext: { [weak self] in
                guard let webViewVC = self?.container.makeWebViewViewController(url: $0.url, title: $0.title) else {
                    return
                }
                
                self?.navigationController?.pushViewController(webViewVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
