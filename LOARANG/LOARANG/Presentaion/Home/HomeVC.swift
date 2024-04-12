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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisAppear()
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
        
        viewModel.setBookmark.withUnretained(self)
            .subscribe { owner, setCase in
                owner.homeView.changedBookmarkUsers(setCase: setCase)
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
                    case .searchView:
                        return owner.container.makeSearchViewController()
                    case .webView(let url, let title):
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
            .subscribe { owner, message in
                owner.showAlert(message: message)
            }
            .disposed(by: disposeBag)
    }
}
