//
//  SearchView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import SnapKit

final class SearchView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainBackground
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, userSearchBar])
        
        return stackView
    }()
    
    private(set) var backButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .buttonColor
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular, scale: .default), forImageIn: .normal)

        return button
    }()
    
    private(set) var userSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "캐릭터 명"
        
        return searchBar
    }()
    
    private func setLayout() {
        self.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
