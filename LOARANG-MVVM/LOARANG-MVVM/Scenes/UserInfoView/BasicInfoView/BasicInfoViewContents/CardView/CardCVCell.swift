//
//  CardCVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/04.
//

import SnapKit

final class CardCVCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 15, family: .Bold)
        label.textAlignment = .center
        label.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        
        return label
    }()
    
    private func setLayout() {
        self.layer.cornerRadius = 10
        
        self.contentView.addSubview(cardImageView)
        self.contentView.addSubview(cardNameLabel)
        
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2)
            $0.leading.trailing.equalToSuperview().inset(2)
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
    }
    
    func setCellContents(card: Card) {
        setLayout()
        
        cardImageView.setImage(urlString: card.imageURL)
        
        let gradeColor = Equips.Grade(rawValue: card.tierGrade)?.textColor
        cardNameLabel.text = card.name
        cardNameLabel.textColor = gradeColor
        cardImageView.layer.borderColor = gradeColor?.cgColor
    }
}
