//
//  CharacterDetailVC.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import UIKit
import RxSwift

final class CharacterDetailVC: UIViewController {
    private let container: Containerable
    private let viewModel: CharacterDetailVMable
    private let charcterDetailView = CharacterDetailView()
    private let disposeBag = DisposeBag()
    
    init(container: Containerable,
         viewModel: CharacterDetailVMable) {
        self.container = container
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = charcterDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.isLoading.withUnretained(self)
            .subscribe { owner, isLoading in
                owner.charcterDetailView.loadingView.isLoading(isLoading)
            }
            .disposed(by: disposeBag)
        
        viewModel.setViewContents.withUnretained(self)
            .subscribe { owner, viewContents in
                owner.charcterDetailView.setViewContents(viewContents: viewContents)
            }
            .disposed(by: disposeBag)
    }
}
