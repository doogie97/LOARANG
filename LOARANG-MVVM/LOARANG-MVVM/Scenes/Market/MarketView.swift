//
//  MarketView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

import SnapKit

final class MarketView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) var itemSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "아이템 명"
        
        return searchBar
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        
        self.addSubview(itemSearchBar)
        
        itemSearchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
    }
}
