//
//  HomeVC.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import RxSwift

final class HomeVC: UIViewController {
    private let container: Containerable
    private let viewModel: HomeVMable
    private let homeView = HomeView()
    private let disposeBag = DisposeBag()
    
    init(container: Containerable,
         viewModel: HomeVMable) {
        self.container = container
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.setViewContents.withUnretained(self)
            .subscribe { owner, viewContents in
                owner.homeView.setViewContents(viewContents: viewContents)
            }
            .disposed(by: disposeBag)
        
        viewModel.reloadMainUserSection.withUnretained(self)
            .subscribe { owner, _ in
                owner.homeView.reloadMainUserSection()
            }
            .disposed(by: disposeBag)
        
        viewModel.reloadBookmark.withUnretained(self)
            .subscribe { owner, setCase in
                owner.homeView.reloadBookmark()
            }
            .disposed(by: disposeBag)
        
        viewModel.appendBookmarkCell.withUnretained(self)
            .subscribe { owner, count in
                owner.homeView.appendCell(count: count)
            }
            .disposed(by: disposeBag)
        
        viewModel.deleteBookmarkCell.withUnretained(self)
            .subscribe { owner, indexPath in
                owner.homeView.deleteCell(indexPath)
            }
            .disposed(by: disposeBag)
        
        viewModel.updateBookmarkCell.withUnretained(self)
            .subscribe { owner, indexPath in
                owner.homeView.updateCell(indexPath)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoading.withUnretained(self)
            .subscribe { owner, isLoading in
                owner.homeView.loadingView.isLoading(isLoading)
            }
            .disposed(by: disposeBag)
        
        viewModel.showNextView.withUnretained(self)
            .subscribe { owner, nextViewCase in
                var nextVC: UIViewController? {
                    switch nextViewCase {
                    case .characterDetailV2(let name):
                        return owner.container.characterDetailVC(name: name)
                    case .characterDetail(let name):
                        return owner.container.makeUserInfoViewController(name,
                                                                          isSearching: false)
                    case .searchView:
                        return owner.container.makeSearchViewController()
                    case .webView(let url, let title):
                        guard let url = URL(string: url ?? "") else {
                            return nil
                        }
                        return owner.container.makeWebViewViewController(url: url, title: title)
                    }
                }
                
                guard let nextVC = nextVC else {
                    return
                }
                
                owner.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.showAlert.withUnretained(self)
            .subscribe { owner, alertCase in
                switch alertCase {
                case .pop(let message):
                    owner.showAlert(message: message) {
                        exit(0)
                    }
                case .basic(let message):
                    owner.showAlert(message: message)
                case .searchMainUser:
                    owner.showSetMainCharacterAlert { name in
                        owner.viewModel.touchViewAction(.searchMainUser(name: name))
                    }
                case .checkMainUer(let userInfo):
                    owner.showCheckUserAlert(userInfo) {
                        owner.viewModel.touchViewAction(.changeMainUser(userInfo: userInfo))
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
