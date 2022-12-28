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
    
    private(set) lazy var itemSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "아이템 명"
        
        return searchBar
    }()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 18, family: .Bold)
        label.text = "카테고리"
        label.textAlignment = .center
        
        return label
    }()
    
    private(set) lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("카테고리를 선택해 주세요", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.one(size: 16, family: .Bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private lazy var directionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.image = UIImage(systemName: "chevron.down")
        
        return imageView
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        
        self.addSubview(itemSearchBar)
        self.addSubview(categoryTitle)
        self.addSubview(categoryButton)
        self.addSubview(directionImageView)
        
        itemSearchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        categoryTitle.snp.makeConstraints {
            $0.top.equalTo(itemSearchBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        categoryButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(categoryTitle.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        directionImageView.snp.makeConstraints {
            $0.centerY.equalTo(categoryButton)
            $0.trailing.equalTo(categoryButton.snp.trailing).inset(16)
        }
    }
}
