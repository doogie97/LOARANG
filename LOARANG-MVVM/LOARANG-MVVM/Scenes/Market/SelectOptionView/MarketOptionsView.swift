//
//  MarketOptionsView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import SnapKit

final class MarketOptionsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var optionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBlue
        
        return tableView
    }()
    
    private func setLayout() {
        self.backgroundColor = .systemRed
        
        self.addSubview(optionsTableView)
        
        optionsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
