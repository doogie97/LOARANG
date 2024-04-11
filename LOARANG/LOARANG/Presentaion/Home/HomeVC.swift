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
        homeView.setViewContents(viewModel: viewModel) //임시 호출
    }
    
    private func bindViewModel() {
        viewModel.showNextView.withUnretained(self)
            .subscribe { owner, nextViewCase in
                var nextVC: UIViewController? {
                    switch nextViewCase {
                    case .searchView:
                        return owner.container.makeSearchViewController()
                    }
                }
                
                guard let nextVC = nextVC else {
                    return
                }
                
                owner.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
