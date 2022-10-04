//
//  RecentUserView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import SnapKit

final class RecentUserView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainBackground
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.font = UIFont.one(size: 16, family: .Bold)
        
        return label
    }()
    
    private(set) lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.titleLabel?.font = UIFont.one(size: 12, family: .Regular)
        button.setTitleColor(.systemGray, for: .normal)
        
        return button
    }()
    
    private(set) lazy var recentUserTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGreen //임시
        
        return tableView
    }()
    
    private func setLayout() {
        self.addSubview(titleLabel)
        self.addSubview(clearButton)
        self.addSubview(recentUserTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        clearButton.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        recentUserTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
