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
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private(set) lazy var equipmentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cellColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(EquipmentCell.self)
        return tableView
    }()
    
    private(set) lazy var accessoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cellColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(EquipmentCell.self)
        
        return tableView
    }()
    
    private lazy var jewelryStackView: UIStackView = {
        let label = UILabel()
        label.text = "나중에 보석 들어올 스택뷰"
        
        let stackView = UIStackView(arrangedSubviews: [label])
        
        return stackView
    }()
    
    private func setLayout() {
        self.addSubview(mainStackView)
        self.addSubview(jewelryStackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(5)
            $0.bottom.equalTo(jewelryStackView.snp.top)
        }
        
        jewelryStackView.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(5)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
}
