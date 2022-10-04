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
    
    private var noRecentUserLabel: PaddingLabel = {
        let label = PaddingLabel(top: 24, bottom: 24, left: 16, right: 16)
        label.text = "최근 검색된 유저가 없습니다"
        label.textAlignment = .center
        label.backgroundColor = .cellColor
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private(set) lazy var recentUserView = RecentUserView()
    
    private func setLayout() {
        self.addSubview(mainStackView)
        self.addSubview(noRecentUserLabel)
        self.addSubview(recentUserView)
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
        
        noRecentUserLabel.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        recentUserView.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
