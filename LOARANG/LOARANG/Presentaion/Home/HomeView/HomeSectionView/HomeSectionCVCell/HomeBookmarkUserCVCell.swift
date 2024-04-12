//
//  HomeBookmarkUserCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeBookmarkUserCVCell: UICollectionViewCell {
    private lazy var imageWidth = margin(.width, 85)
    private lazy var characterImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.2
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageWidth / 2
        
        return imageView
    }()
    func setCellContents(userInfo: BookmarkUserEntity) {
        self.contentView.backgroundColor = .cellColor
        self.characterImageView.image = userInfo.image.cropImage(class: userInfo.class)
        self.contentView.layer.cornerRadius = 6
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(characterImageView)
        characterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.width, 24))
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(imageWidth)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
