//
//  BasicEquipmentView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import SnapKit

final class BasicEquipmentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [equipmentTableView, accessoryTableView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private(set) lazy var equipmentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .tableViewColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(EquipmentCell.self)
        return tableView
    }()
    
    private(set) lazy var accessoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBlue
        
        return tableView
    }()
    
    private func setLayout() {
        self.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
