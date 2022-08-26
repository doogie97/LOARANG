//
//  SkillDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import RxSwift

final class SkillDetailViewController: UIViewController {
    private let viewModel: SkillDetailViewModelable
    
    init(viewModel: SkillDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let skillDetailView = SkillDetailView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = skillDetailView
    }
    
    override func viewDidLoad() {
        skillDetailView.setViewContents(viewModel.skill)
        bindView()
    }
    
    private func bindView() {
        viewModel.dismiss
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        skillDetailView.closeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchCloseButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.tripods
            .bind(to: skillDetailView.tripodsTableView.rx.items(cellIdentifier: "\(TripodTVCell.self)", cellType: TripodTVCell.self)) { index, tripod, cell in
                cell.setCellContents(tripod: tripod)
            }
            .disposed(by: disposeBag)
    }
}
