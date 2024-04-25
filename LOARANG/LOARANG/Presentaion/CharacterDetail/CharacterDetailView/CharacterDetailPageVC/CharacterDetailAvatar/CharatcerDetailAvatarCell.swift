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
    
    func setCellContents(gem: CharacterDetailEntity.Gem) {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .cellBackgroundColor
        
        avatarImageView.setImage(gem.imageUrl)
        avatarImageView.backgroundColor = gem.grade.backgroundColor
        
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(margin(.width, 16))
            $0.height.width.equalTo(50)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
    }
}

