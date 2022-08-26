//
//  AvatarDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import RxSwift

final class AvatarDetailViewController: UIViewController {
    private let viewModel: AvatarDetailViewModelable
    
    init(viewModel: AvatarDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let avatarDetailView = AvatarDetailView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = avatarDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarDetailView.setViewContents(viewModel.equipmentInfo)
        bindView()
    }
    
    private func bindView() {
        viewModel.dismiss
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        avatarDetailView.closeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchCloseButton()
            })
            .disposed(by: disposeBag)
    }
}
