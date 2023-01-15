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
    
    private(set) lazy var marketOptionView = MarketOptionView()
    private(set) lazy var marketItemListView = MarketItemListView()
    
    private(set) lazy var noItemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "아이템을 검색해 주세요"
        label.font = .one(size: 20, family: .Bold)
        
        return label
    }()
    
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

        self.addSubview(marketOptionView)
        self.addSubview(marketItemListView)
        self.addSubview(noItemLabel)
        self.addSubview(blurButtonView)
        self.addSubview(categoryOptionView)
        self.addSubview(subOptionsTableView)

        marketOptionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

        marketItemListView.snp.makeConstraints {
            $0.top.equalTo(marketOptionView.snp.bottom).offset(16)
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
        }
        
        noItemLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        blurButtonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
}

