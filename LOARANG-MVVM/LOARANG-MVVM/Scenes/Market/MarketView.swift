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
    
    private(set) lazy var classButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("전체 직업", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.one(size: 16, family: .Bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private lazy var categoryButtonView = makeButtonView(button: categoryButton)
    private lazy var classButtonView = makeButtonView(button: classButton)
    
    private func makeButtonView(button: UIButton) -> UIView {
        let view = UIView()
        
        let directionImageView = UIImageView()
        directionImageView.tintColor = .label
        directionImageView.image = UIImage(systemName: "chevron.down")
        
        view.addSubview(button)
        view.addSubview(directionImageView)
        
        button.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        directionImageView.snp.makeConstraints {
            $0.centerY.equalTo(button)
            $0.trailing.equalTo(button.snp.trailing).inset(16)
        }
        
        return view
    }
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        
        self.addSubview(itemSearchBar)
        self.addSubview(categoryButtonView)
        self.addSubview(classButtonView)
        
        itemSearchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        categoryButtonView.snp.makeConstraints {
            $0.top.equalTo(itemSearchBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        classButtonView.snp.makeConstraints {
            $0.top.equalTo(categoryButtonView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.centerX).inset(16)
        }
    }
}
