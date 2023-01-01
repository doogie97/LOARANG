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
    
    private(set) lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.one(size: 16, family: .Bold)
        
        return button
    }()
    
    private(set) lazy var categoryButton: UIButton = makeButton(tag: 0)
    private(set) lazy var classButton: UIButton = makeButton(tag: 1)
    private(set) lazy var gradeButton: UIButton = makeButton(tag: 2)
    
    private lazy var categoryButtonView = makeButtonView(button: categoryButton, directionInset: 16)
    private lazy var classButtonView = makeButtonView(button: classButton, directionInset: 8)
    private lazy var gradeButtonView = makeButtonView(button: gradeButton, directionInset: 8)
    
    private lazy var bottomButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [classButtonView, gradeButtonView])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private func makeButton(tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.one(size: 12, family: .Bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
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
    
    private(set) lazy var categoryOptionView = CategoryOptionView()
    
    private(set) lazy var subOptionsTableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.register(OptionCell.self)
        tableView.separatorStyle = .none
        tableView.layer.opacity = 0
        tableView.backgroundColor = .mainBackground
        tableView.layer.cornerRadius = 10
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return tableView
    }()
    
    private(set) lazy var blurButtonView: UIButton = {
        let button = UIButton()
        button.layer.opacity = 0
        button.isHidden = true
        button.backgroundColor = .black
        
        return button
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        
        self.addSubview(itemSearchBar)
        self.addSubview(searchButton)
        self.addSubview(categoryButtonView)
        self.addSubview(bottomButtonStackView)
        self.addSubview(blurButtonView)
        self.addSubview(categoryOptionView)
        self.addSubview(subOptionsTableView)

        itemSearchBar.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(searchButton.snp.leading).inset(-8)
        }
        
        searchButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.centerY.equalTo(itemSearchBar)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        categoryButtonView.snp.makeConstraints {
            $0.top.equalTo(itemSearchBar.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        bottomButtonStackView.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        blurButtonView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        categoryOptionView.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        subOptionsTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func showOptionView(view: UIView) {
        view.snp.remakeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(UIScreen.main.bounds.height / 3)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.blurButtonView.isHidden = false
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.blurButtonView.layer.opacity = 0.7
            view.layer.opacity = 1
            self?.layoutIfNeeded()
        }
    }
    
    func hideOptionView(view: UIView) {
        view.snp.remakeConstraints {
            $0.height.equalTo(0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.blurButtonView.isHidden = true
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.blurButtonView.layer.opacity = 0
            view.layer.opacity = 0
            self?.layoutIfNeeded()
        }
    }
    
    func setButtonActivation(_ buttonType: ButtonType) {
        switch buttonType {
        case .classButtonActive:
            setClassButtonActivation(isActive: true)
            setGradeButtonActivation(isActive: false)
        case .gradeButtonActive:
            setClassButtonActivation(isActive: false)
            setGradeButtonActivation(isActive: true)
        case .allActive:
            setClassButtonActivation(isActive: true)
            setGradeButtonActivation(isActive: true)
        case .allInAcitve:
            setClassButtonActivation(isActive: false)
            setGradeButtonActivation(isActive: false)
        }
    }
    
    private func setClassButtonActivation(isActive: Bool) {
        classButton.isEnabled = isActive
        classButtonView.layer.opacity = isActive ? 1 : 0.3
    }
    
    private func setGradeButtonActivation(isActive: Bool) {
        gradeButton.isEnabled = isActive
        gradeButtonView.layer.opacity = isActive ? 1 : 0.3
    }
}

extension MarketView {
    enum ButtonType {
        case classButtonActive
        case gradeButtonActive
        case allActive
        case allInAcitve
    }
}
