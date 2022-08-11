//
//  BasicInfoView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import SnapKit

final class BasicInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var basicInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MainInfoTVCell.self)
        tableView.register(BasicAbilityTVCell.self)
        
        tableView.backgroundColor = .tableViewColor
        
        return tableView
    }()
    
    private func setLayout() {
        self.addSubview(basicInfoTableView)
        
        basicInfoTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
