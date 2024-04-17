//
//  SkillDetailVC.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import UIKit
import RxSwift

final class SkillDetailVC: UIViewController {
    private let viewModel: SkillDetailViewModelable? = nil
    private let skill: Skill
    
    init(skill: Skill) {
        self.skill = skill
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
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
        skillDetailView.setViewContents(skill)
        bindView()
    }
    
    private func bindView() {
        viewModel?.dismiss
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        skillDetailView.closeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel?.tripods
            .bind(to: skillDetailView.tripodsTableView.rx.items(cellIdentifier: "\(TripodTVCell.self)", cellType: TripodTVCell.self)) { index, tripod, cell in
                cell.setCellContents(tripod: tripod)
            }
            .disposed(by: disposeBag)
    }
}
