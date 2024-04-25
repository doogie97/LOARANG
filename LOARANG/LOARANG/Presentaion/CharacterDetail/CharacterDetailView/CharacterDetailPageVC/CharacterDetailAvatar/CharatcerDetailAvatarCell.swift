//
//  CharatcerDetailAvatarCell.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharatcerDetailAvatarCell: UITableViewCell {
    private lazy var avatarImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        
        return imageView
    }()
    
    private lazy var avatarTypeLabel = pretendardLabel(family: .SemiBold)
    private lazy var nameLabel = pretendardLabel()
    
    private lazy var overdressingLabel = {
        let label = PaddingLabel(top: 0, bottom: 0, left: 8, right: 8)
        label.font = .pretendard(size: 14, family: .SemiBold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        label.isHidden = true
        label.text = "덧입기"
        
        return label
    }()
    
    func setCellContents(avatar: CharacterDetailEntity.Avatar) {
        self.selectionStyle = .none
        self.contentView.backgroundColor = #colorLiteral(red: 0.07950355858, green: 0.09458512813, blue: 0.1114221141, alpha: 1)
        
        avatarImageView.setImage(avatar.imageUrl)
        avatarImageView.backgroundColor = avatar.grade.backgroundColor
        
        avatarTypeLabel.text = avatar.avatarType.rawValue
        
        nameLabel.text = avatar.name
        nameLabel.textColor = avatar.grade.textColor
        
        overdressingLabel.isHidden = !avatar.isOverdressing
        
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(avatarTypeLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(overdressingLabel)
        
        avatarImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(margin(.width, 16))
            $0.height.width.equalTo(50)
        }
        
        avatarTypeLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView).inset(margin(.width, 4))
            $0.leading.equalTo(avatarImageView.snp.trailing).inset(margin(.width, -8))
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(avatarImageView).inset(margin(.width, 4))
            $0.leading.equalTo(avatarImageView.snp.trailing).inset(margin(.width, -8))
        }
        
        overdressingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(margin(.width, 16))
            $0.height.equalTo(25)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
    }
}

