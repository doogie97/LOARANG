//
//  CharacterDetailSkillView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

import UIKit
import SnapKit

final class CharacterDetailSkillView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
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
        tableView.register(CharcterDetailSkillCell.self)
        
        return tableView
    }()
    
    private func setLayout() {
        self.addSubview(skillPointLabel)
        self.addSubview(skillTableView)
        
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
    
    func setViewContents(skillPointString: String) {
        self.skillPointLabel.text = skillPointString
    }
}
