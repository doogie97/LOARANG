//
//  CharcterDetailSkillVC.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit
import RxSwift

final class CharcterDetailSkillVC: UIViewController, PageViewInnerVCDelegate {
    private let viewModel: SkillInfoViewModelable = SkillInfoViewModel()
    
    init() {
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let characterDetailSkillView = CharacterDetailSkillView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = characterDetailSkillView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        guard let characterDetail = viewModel?.characterInfoData else {
            return
        }
        self.viewModel.viewDidLoad(characterDetail)
    }
    
    private func bindView() {
        viewModel.skillInfo
            .bind(onNext: {[weak self] in
                let skillPointString = "스킬 포인트 : \($0?.usedSkillPoint ?? "") / \($0?.totalSkillPoint ?? "")"
                self?.characterDetailSkillView.setViewContents(skillPointString: skillPointString)
            })
            .disposed(by: disposeBag)
        
        viewModel.skills
            .bind(to: characterDetailSkillView.skillTableView.rx.items(cellIdentifier: "\(CharcterDetailSkillCell.self)", cellType: CharcterDetailSkillCell.self)){ index, skill, cell in
                    cell.setCellContents(skill: skill)
            }
            .disposed(by: disposeBag)
        
        viewModel.showSkillDetailView
            .bind(onNext: { [weak self] _ in
//                guard let skillDetailVC = self?.container.makeSkillDetailViewController(skill: $0) else {
//                    return
//                }
//                
//                self?.present(skillDetailVC, animated: true)
                print("스킬 상세 노출")
                
            })
            .disposed(by: disposeBag)
        
        characterDetailSkillView.skillTableView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSkillCell($0.row)
            })
            .disposed(by: disposeBag)
    }
}
