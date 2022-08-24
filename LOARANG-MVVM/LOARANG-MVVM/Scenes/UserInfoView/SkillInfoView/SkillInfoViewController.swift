//
//  SkillInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import RxSwift

final class SkillInfoViewController: UIViewController {
    private let viewModel: SkillInfoViewModelable
    
    init(viewModel: SkillInfoViewModelable) {
        self.viewModel = viewModel
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
        setViewContents()
        bindView()
    }
    
    private func setViewContents() {
        let skillPointString = "스킬 포인트 : \(viewModel.usedSkillPoint) / \(viewModel.totalSkillPoint)"
        skillInfoView.setViewContents(skillPointString: skillPointString)
    }
    
    private func bindView() {
        viewModel.skills
            .bind(to: skillInfoView.skillTableView.rx.items(cellIdentifier: "\(SkillTVCell.self)", cellType: SkillTVCell.self)){ index, skill, cell in
                
            }
            .disposed(by: disposeBag)
    }
}
