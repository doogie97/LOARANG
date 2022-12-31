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
    
    private(set) lazy var mainOptionTableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.register(CategoryOptionCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private func setLayout() {
        viewShapeSetting()
        self.addSubview(mainOptionTableView)
        
        mainOptionTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func viewShapeSetting() {
        self.layer.opacity = 0
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.backgroundColor = .mainBackground
    }
}
