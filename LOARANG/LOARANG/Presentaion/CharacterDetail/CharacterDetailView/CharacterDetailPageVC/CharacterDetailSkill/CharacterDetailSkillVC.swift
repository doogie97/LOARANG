//
//  CharacterDetailSkillVC.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit
import SnapKit

final class CharacterDetailSkillVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    
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
    
    private lazy var skillTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .mainBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharcterDetailSkillCell.self)
        
        return tableView
    }()
    
    private lazy var separatorView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5
        separatorView.isHidden = true
        return separatorView
    }()
    
    private func setLayout() {
        self.view.addSubview(skillPointLabel)
        self.view.addSubview(separatorView)
        self.view.addSubview(skillTableView)
        
        skillPointLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(skillPointLabel.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        skillTableView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
        let skillInfo = viewModel?.characterInfoData?.skillInfo
        skillPointLabel.text = "스킬 포인트 : \(skillInfo?.usedSkillPoint ?? "") / \(skillInfo?.totalSkillPoint ?? "")"
    }
}

extension CharacterDetailSkillVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characterInfoData?.skillInfo.skills.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharcterDetailSkillCell.self)") as? CharcterDetailSkillCell,
              let skill = viewModel?.characterInfoData?.skillInfo.skills[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellContents(skill: skill)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.touchSkillCell(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y <= 10 {
            self.separatorView.isHidden = true
        }
        
        if scrollView.contentOffset.y > 10 {
            self.separatorView.isHidden = false
        }
    }
}
