//
//  MarketItemListView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/15.
//

import SnapKit

final class MarketItemListView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var marketItemTableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.separatorStyle = .none
        tableView.register(MarketItemCell.self)
        
        return tableView
    }()
    
    private func setLayout() {
        self.addSubview(marketItemTableView)
        
        marketItemTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
