//
//  SettingView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/04.
//

import SnapKit

final class SettingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        
        label.font = UIFont.one(size: 30, family: .Bold)
        
        return label
    }()
    
    private(set) lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .tableViewColor
        tableView.separatorStyle = .none
        
        tableView.register(SettingTVCell.self)
        
        return tableView
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.addSubview(titleLabel)
        self.addSubview(menuTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        menuTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
