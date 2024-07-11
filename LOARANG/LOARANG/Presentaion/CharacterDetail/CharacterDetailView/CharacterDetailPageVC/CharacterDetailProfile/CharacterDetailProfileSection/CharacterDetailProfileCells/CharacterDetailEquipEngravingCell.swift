//
//  CharacterDetailEquipEngravingCell.swift
//  LOARANG
//
//  Created by Doogie on 5/18/24.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterDetailEquipEngravingCell: UICollectionViewCell {
    private var engravingStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var noEngravingLabel = pretendardLabel(size: 14, family: .SemiBold, text: "장착 각인 없음", alignment: .center)
    
    func setCellContents(engravings: [CharacterDetailEntity.EquipEngravig]) {
        self.contentView.backgroundColor = .cellColor
        self.contentView.layer.cornerRadius = 6
        engravingStackView.isHidden = engravings.isEmpty
        noEngravingLabel.isHidden = !engravings.isEmpty
        addEngravingView(engravings)
        setLayout()
    }
    
    private func addEngravingView(_ engravings: [CharacterDetailEntity.EquipEngravig]) {
        for engraving in engravings {
            let view = UIView()
            let imageView = UIImageView()
            imageView.setImage(engraving.imageUrl)
            imageView.layer.cornerRadius = 27.5
            imageView.clipsToBounds = true
            
            let intValue = Int(engraving.value) ?? 0
            var nameColor: UIColor {
                switch intValue {
                case 0...3:
                    return #colorLiteral(red: 0.5529411765, green: 0.9764705882, blue: 0.003921568627, alpha: 1)
                case 4...6:
                    return #colorLiteral(red: 0, green: 0.6901960784, blue: 0.9803921569, alpha: 1)
                case 7...9:
                    return #colorLiteral(red: 0.8078431373, green: 0.262745098, blue: 0.9882352941, alpha: 1)
                case 10...12:
                    return #colorLiteral(red: 0.9764705882, green: 0.5725490196, blue: 0, alpha: 1)
                default:
                    return .white
                }
            }
            
            let nameLabel = pretendardLabel(
                size: 15, family: .SemiBold, color: nameColor, text: engraving.name
            )
            
            let valueLabel = pretendardLabel(size: 15, family: .SemiBold, text: "활성도+\(intValue)")
            
            view.addSubview(imageView)
            view.addSubview(nameLabel)
            view.addSubview(valueLabel)
            
            imageView.snp.makeConstraints {
                $0.height.width.equalTo(55)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(margin(.width, 8))
            }
            
            nameLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(24)
                $0.leading.equalTo(imageView.snp.trailing).inset(margin(.width, -16))
            }
            
            valueLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(24)
                $0.leading.equalTo(nameLabel)
            }
            
            engravingStackView.addArrangedSubview(view)
        }
    }
    
    private func setLayout() {
        self.contentView.addSubview(engravingStackView)
        self.contentView.addSubview(noEngravingLabel)
        
        engravingStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        noEngravingLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        engravingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
