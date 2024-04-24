//
//  CharacterDetailCardEffectCell.swift
//  LOARANG
//
//  Created by Doogie on 4/23/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailCardEffectCell: UICollectionViewCell {
    private lazy var stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        
        return stackView
    }()
    
    func setCellContents(effects: [CharacterDetailEntity.CardEffect]) {
        self.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.contentView.layer.cornerRadius = 6
        self.contentView.backgroundColor = .cellColor
        
        for effect in effects {
            let effectView = UIView()

            let nameLabel = pretendardLabel(size: 16, color: #colorLiteral(red: 0.3921568627, green: 0.7529411765, blue: 0.5058823529, alpha: 1), text: effect.name)
            let descriptionLabel = pretendardLabel(family: .SemiBold, text: "• " + effect.description, lineCount: 2)
            nameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            nameLabel.setContentHuggingPriority(.required, for: .vertical)
            descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
            
            effectView.addSubview(nameLabel)
            effectView.addSubview(descriptionLabel)
            nameLabel.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
            }
            
            descriptionLabel.snp.makeConstraints {
                $0.top.equalTo(nameLabel.snp.bottom).inset(margin(.width, -4))
                $0.leading.trailing.bottom.equalToSuperview()
            }
            stackView.addArrangedSubview(effectView)
        }
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
