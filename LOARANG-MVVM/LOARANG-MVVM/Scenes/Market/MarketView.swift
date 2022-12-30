//
//  MarketView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

import SnapKit

final class MarketView: UIView {
    private let modalHeight = UIScreen.main.bounds.height * 0.6
    
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
    
    private(set) lazy var categoryButton: UIButton = makeButton(title: "카테고리를 선택해 주세요")
    private(set) lazy var classButton: UIButton = makeButton(title: "전체 직업")
    private(set) lazy var gradeButton: UIButton = makeButton(title: "전체 등급")
    private(set) lazy var tierButton: UIButton = makeButton(title: "전체 티어")
    
    private lazy var categoryButtonView = makeButtonView(button: categoryButton, directionInset: 16)
    private lazy var classButtonView = makeButtonView(button: classButton, directionInset: 8)
    private lazy var gradeButtonView = makeButtonView(button: gradeButton, directionInset: 8)
    private lazy var tierButtonView = makeButtonView(button: tierButton, directionInset: 8)
    
    private lazy var bottomButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [classButtonView, gradeButtonView, tierButtonView])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.one(size: 14, family: .Bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        
        return button
    }
    
    private func makeButtonView(button: UIButton, directionInset: Int) -> UIView {
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
            $0.height.equalTo(16)
            $0.width.equalTo(12)
            $0.centerY.equalTo(button)
            $0.trailing.equalTo(button.snp.trailing).inset(directionInset)
        }
        
        return view
    }
    
    private(set) lazy var subOptionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.opacity = 0
        tableView.backgroundColor = .systemBlue
        tableView.layer.cornerRadius = 10
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return tableView
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        
        self.addSubview(itemSearchBar)
        self.addSubview(categoryButtonView)
        self.addSubview(bottomButtonStackView)
        self.addSubview(subOptionsTableView)
        
        itemSearchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        categoryButtonView.snp.makeConstraints {
            $0.top.equalTo(itemSearchBar.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        bottomButtonStackView.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        subOptionsTableView.snp.makeConstraints {
            $0.height.equalTo(modalHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(modalHeight)
        }
    }
}
