//
//  CharacterDetailSkillCell.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class CharacterDetailSkillCell: UITableViewCell {
    private lazy var backView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        
        return view
    }()
    
    func setCellContents() {
        self.selectionStyle = .none
        self.backgroundColor = .mainBackground
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
            
            $0.height.equalTo(300)//임시 높이
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
