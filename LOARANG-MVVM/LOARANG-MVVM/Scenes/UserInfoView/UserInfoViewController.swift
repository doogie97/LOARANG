//
//  UserInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxSwift

final class UserInfoViewController: UIViewController {
    private let viewModel: UserInfoViewModelable
    
    init(viewModel: UserInfoViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let userInfoView = UserInfoView()
    private let disposBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = userInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoView.setCellContents(viewModel.userInfo)
        bindView()
    }
    
    func bindView() {
        userInfoView.backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBackButton()
            })
            .disposed(by: disposBag)
        
        viewModel.popView
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposBag)
        
        userInfoView.segmentController.segmentController.rx.value
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSegmentControl($0)
            })
            .disposed(by: disposBag)
        
        viewModel.detailVC
            .bind(onNext: { [weak self] in
                print($0.self)
            })
            .disposed(by: disposBag)
    }
}
