//
//  GemDetailCell.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit
import Kingfisher

final class GemDetailCell: UITableViewCell {
    private lazy var gemImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        
        return imageView
    }()
    
    private lazy var nameLabel = pretendardLabel()
    private lazy var descriptionLabel = pretendardLabel(family: .SemiBold)
    
    func setCellContents(gem: CharacterDetailEntity.Gem) {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .cellBackgroundColor
        
        gemImageView.setImage(gem.imageUrl)
        gemImageView.backgroundColor = gem.grade.backgroundColor
        
        nameLabel.text = gem.name
        nameLabel.textColor = gem.grade.textColor
        
        descriptionLabel.text = gem.description
        
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(gemImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(descriptionLabel)
        
        gemImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(margin(.width, 16))
            $0.height.width.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(gemImageView).inset(margin(.width, 4))
            $0.leading.equalTo(gemImageView.snp.trailing).inset(margin(.width, -8))
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(gemImageView).inset(margin(.width, 4))
            $0.leading.equalTo(gemImageView.snp.trailing).inset(margin(.width, -8))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


