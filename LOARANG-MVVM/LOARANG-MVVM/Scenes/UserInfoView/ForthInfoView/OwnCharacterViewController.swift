//
//  OwnCharacterViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import RxSwift

final class OwnCharacterViewController: UIViewController {
    private let viewModel: OwnCharacterViewModelable
    
    init(viewModel: OwnCharacterViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let ownCharacterView = OwnCharacterView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = ownCharacterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
            }
            .disposed(by: disposeBag)
    }
}
