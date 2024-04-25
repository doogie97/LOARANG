//
//  CharacterDetailGemCell.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailGemCell: UICollectionViewCell {
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        
        return imageView
    }()
    
    private lazy var levelLabel = {
        let label = pretendardLabel(size: 14, family: .SemiBold, color: .systemOrange, alignment: .center)
        label.backgroundColor = .cellBackgroundColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.systemGray.cgColor
        
        return label
    }()
    
    func setCellContents(gem: CharacterDetailEntity.Gem) {
        imageView.setImage(gem.imageUrl)
        imageView.backgroundColor = gem.grade.backgroundColor
        levelLabel.text = gem.level.description
        
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(levelLabel)
        
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(60)
            $0.center.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.height.width.equalTo(23)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}
