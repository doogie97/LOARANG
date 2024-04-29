//
//  SettingTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/10.
//

import UIKit
import SnapKit

final class SettingTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        
        return view
    }()
    
    
    private lazy var menuStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [menuLabel, directionImageView])
        
        return stackView
    }()
    
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴임"
        label.font = UIFont.one(size: 15, family: .Bold)
        
        return label
    }()
    
    private lazy var directionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.image = UIImage(systemName: "chevron.right")
        
        return imageView
    }()
    
    private func setLayout() {
        self.backgroundColor = .tableViewColor
        self.selectionStyle = .none
        
        backView.addSubview(menuStackView)
        self.addSubview(backView)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        menuStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
        
        directionImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.03)
        }
    }
    
    func setCellContents(title: String) {
        menuLabel.text = title
    }
}
