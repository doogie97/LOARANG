//
//  SkillInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit
import RxSwift

final class SkillInfoViewController: UIViewController {
    private let viewModel: SkillInfoViewModelable
    private let container: Container
    
    init(viewModel: SkillInfoViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let skillInfoView = SkillInfoView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = skillInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        viewModel.skillInfo
            .bind(onNext: {[weak self] in
                let skillPointString = "스킬 포인트 : \($0?.usedSkillPoint ?? "") / \($0?.totalSkillPoint ?? "")"
                self?.skillInfoView.setViewContents(skillPointString: skillPointString)
            })
            .disposed(by: disposeBag)
        
        viewModel.skills
            .bind(to: skillInfoView.skillTableView.rx.items(cellIdentifier: "\(SkillTVCell.self)", cellType: SkillTVCell.self)){ index, skill, cell in
                    cell.setCellContents(skill: skill)
            }
            .disposed(by: disposeBag)
        
        viewModel.showSkillDetailView
            .bind(onNext: { [weak self] in
                guard let skillDetailVC = self?.container.makeSkillDetailViewController(skill: $0) else {
                    return
                }
                
                self?.present(skillDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        skillInfoView.skillTableView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSkillCell($0.row)
            })
            .disposed(by: disposeBag)
    }
}
