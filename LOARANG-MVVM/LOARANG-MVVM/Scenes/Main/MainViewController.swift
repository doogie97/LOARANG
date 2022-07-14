//
//  ViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
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
        mainView.searchButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.pushViewController(SearchViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
}

