//
//  CategoryOptionView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import SnapKit

final class CategoryOptionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var mainOptionTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBlue
        tableView.register(CategoryOptionCell.self)
        
        return tableView
    }()
    
    private func setLayout() {
        self.backgroundColor = .systemRed
        
        self.addSubview(mainOptionTableView)
        
        mainOptionTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
