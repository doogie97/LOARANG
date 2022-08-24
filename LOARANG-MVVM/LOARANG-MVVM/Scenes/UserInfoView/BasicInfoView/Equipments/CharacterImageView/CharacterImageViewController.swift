//
//  CharacterImageViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import RxSwift

final class CharacterImageViewController: UIViewController {
    private let viewModel: CharacterImageViewModelable
    
    init(viewModel: CharacterImageViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let characterImageView = CharacterImageView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = characterImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        characterImageView.setUserImageView(viewModel.userImage)
        
        characterImageView.shareButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchShareButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.showActivityVC
            .bind(onNext: { [weak self] in
                let activityVC = UIActivityViewController(activityItems: [$0], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self?.view
                
                self?.present(activityVC, animated: true)
                //시뮬레이터에서는 오토레이아웃 오류 발생, 실 기기에서는 정상적으로 작동 됨
                //공유 기능에 문제 있는것이 아니어서 일단 넘김
            })
            .disposed(by: disposeBag)
    }
}
