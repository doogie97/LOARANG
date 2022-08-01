//
//  UserMainInfoTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import SnapKit

final class UserMainInfoTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backgourndView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.backgroundColor = .cellColor
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    private func setLayout() {
        self.backgroundColor = .tableViewColor
        self.contentView.addSubview(backgourndView)
        self.backgourndView.addSubview(mainStackView)
        
        backgourndView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}
