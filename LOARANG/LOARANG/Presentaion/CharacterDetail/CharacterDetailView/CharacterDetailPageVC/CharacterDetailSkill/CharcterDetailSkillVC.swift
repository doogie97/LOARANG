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
    private weak var newViewModel: CharacterDetailVMable?
    
    init() {
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var skillPointLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .one(size: 15, family: .Bold)
        
        return label
    }()
    
    private(set) lazy var skillTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .mainBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(CharcterDetailSkillCell.self)
        
        return tableView
    }()
    
    private func setLayout() {
        self.view.addSubview(skillPointLabel)
        self.view.addSubview(skillTableView)
        
        skillPointLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }
        
        skillTableView.snp.makeConstraints {
            $0.top.equalTo(skillPointLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    
    
    
    
    
    
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.newViewModel = viewModel
        let skillInfo = viewModel?.characterInfoData?.skillInfo
        
        skillPointLabel.text = "스킬 포인트 : \(skillInfo?.usedSkillPoint ?? "") / \(skillInfo?.totalSkillPoint ?? "")"
        
        
        
        
        
        guard let characterDetail = viewModel?.characterInfoData else {
            return
        }
        self.viewModel.viewDidLoad(characterDetail)
    }
    
    private let characterDetailSkillView = CharacterDetailSkillView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
//        self.view = characterDetailSkillView
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

extension CharcterDetailSkillVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newViewModel?.characterInfoData?.skillInfo.skills.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharcterDetailSkillCell.self)") as? CharcterDetailSkillCell,
              let skill = newViewModel?.characterInfoData?.skillInfo.skills[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellContents(skill: skill)
        return cell
    }
}
