//
//  CharacterDetailSkillCell.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class CharacterDetailSkillCell: UITableViewCell {
    private lazy var skillImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        
        return imageView
    }()
    
    private lazy var skillNameLabel = pretendardLabel(size: 16, family: .SemiBold)
    private lazy var skillLevelLabel = pretendardLabel(size: 14, family: .Regular, color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), alignment: .right)
    
    private lazy var backView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        view.addSubview(skillImageView)
        view.addSubview(skillNameLabel)
        view.addSubview(skillLevelLabel)
        
        skillImageView.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.top.leading.equalToSuperview().inset(margin(.width, 10))
            $0.bottom.equalToSuperview().inset(30)//다음 뷰로 이동
        }
        
        skillNameLabel.snp.makeConstraints {
            $0.top.equalTo(skillImageView).inset(2)
            $0.leading.equalTo(skillImageView.snp.trailing).inset(margin(.width, -16))
        }
        
        skillLevelLabel.snp.makeConstraints {
            $0.centerY.equalTo(skillNameLabel)
            $0.trailing.equalToSuperview().inset(margin(.width, 16))
        }
        
        return view
    }()
    
    func setCellContents(skill: CharacterDetailEntity.Skill) {
        self.selectionStyle = .none
        self.backgroundColor = .mainBackground
        
        skillImageView.setImage(skill.imageUrl)
        skillNameLabel.text = skill.name
        skillLevelLabel.text = "스킬 레벨 " + skill.level.description
        
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skillImageView.kf.cancelDownloadTask()
        skillImageView.image = nil
    }
}
