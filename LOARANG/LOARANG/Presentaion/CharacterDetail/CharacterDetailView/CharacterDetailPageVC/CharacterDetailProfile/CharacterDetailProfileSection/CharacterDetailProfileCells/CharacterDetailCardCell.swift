//
//  CharacterDetailCardCell.swift
//  LOARANG
//
//  Created by Doogie on 4/23/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailCardCell: UICollectionViewCell {
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    private lazy var topBlurView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.7
        
        return view
    }()
    
    private lazy var nameLabel = pretendardLabel(size: 12, family: .SemiBold, alignment: .center)
    
    func setCellContents(card: CharacterDetailEntity.Card) {
        imageView.setImage(card.imageUrl)
        imageView.layer.borderColor = card.grade.textColor.cgColor
        nameLabel.text = card.name
        nameLabel.textColor = card.grade.textColor
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        self.imageView.addSubview(topBlurView)
        self.contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topBlurView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints {
            $0.edges.equalTo(topBlurView)
        }
    }
}
