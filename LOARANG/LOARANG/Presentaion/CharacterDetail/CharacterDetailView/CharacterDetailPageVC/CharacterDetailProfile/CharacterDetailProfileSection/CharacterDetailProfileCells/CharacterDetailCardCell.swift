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
    
    private lazy var pointStackview = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = -3
        for _ in 0..<5 {
            stackView.addArrangedSubview(UIImageView())
        }
        return stackView
    }()
    
    func setCellContents(card: CharacterDetailEntity.Card) {
        imageView.setImage(card.imageUrl)
        imageView.layer.borderColor = card.grade.textColor.cgColor
        nameLabel.text = card.name
        nameLabel.textColor = card.grade.textColor
        setAwakePoint(totalCount: card.awakeTotal, awakeCount: card.awakeCount)
        setLayout()
    }
    
    private func setAwakePoint(totalCount: Int, awakeCount: Int) {
        if awakeCount > 0 {
            for index in 0..<awakeCount {
                (pointStackview.arrangedSubviews[index] as? UIImageView)?.image = UIImage(named: "activeGem")
            }
        }
        
        if awakeCount < 5 {
            for index in awakeCount..<totalCount {
                (pointStackview.arrangedSubviews[index] as? UIImageView)?.image = UIImage(named: "inActiveGem")
            }
        }
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        self.imageView.addSubview(topBlurView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(pointStackview)
        
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
        
        pointStackview.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }
    }
}
