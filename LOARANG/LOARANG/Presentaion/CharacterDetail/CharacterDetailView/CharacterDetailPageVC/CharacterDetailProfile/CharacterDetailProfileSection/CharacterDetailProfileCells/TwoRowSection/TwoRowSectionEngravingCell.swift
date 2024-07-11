//
//  TwoRowSectionEngravingCell.swift
//  LOARANG
//
//  Created by Doogie on 4/21/24.
//

import UIKit
import SnapKit
import Kingfisher

final class TwoRowSectionEngravingCell: UICollectionViewCell {
    private lazy var titleLabel = {
        let label = pretendardLabel(text: "각인", alignment: .center)
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        label.layer.borderColor = UIColor.systemGray.cgColor
        label.layer.borderWidth = 0.5
        
        return label
    }()
    
    private lazy var engravigStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    func setCellContents(_ engravigs: [CharacterDetailEntity.Engravig]) {
        self.contentView.backgroundColor = .cellColor
        self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.contentView.layer.cornerRadius = 6
        setStackView(engravigs)
        setLayout()
    }
    
    private func setStackView(_ engravigs: [CharacterDetailEntity.Engravig]) {
        for i in 0..<6 {
            if let engravig = engravigs[safe: i] {
                let view = UIView()
                let imageView = UIImageView()
                imageView.setImage(engravig.imageUrl)
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 20
                let titleLabel = pretendardLabel(text: "Lv.\(engravig.level) \(engravig.name)")
                
                view.addSubview(imageView)
                view.addSubview(titleLabel)
                imageView.snp.makeConstraints {
                    $0.height.width.equalTo(40)
                    $0.top.leading.equalToSuperview()
                }
                
                titleLabel.snp.makeConstraints {
                    $0.centerY.equalTo(imageView)
                    $0.leading.equalTo(imageView.snp.trailing).inset(margin(.width, -8))
                }
                
                engravigStackView.addArrangedSubview(view)
            } else {
                engravigStackView.addArrangedSubview(UIView())
            }
        }
    }
    
    private func setLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(engravigStackView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.width, 16))
            $0.leading.equalToSuperview().inset(margin(.width, 4))
            $0.height.equalTo(24)
            $0.width.equalTo(68)
        }
        
        engravigStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        engravigStackView.subviews.forEach {
            let imageView = $0 as? UIImageView
            imageView?.kf.cancelDownloadTask()
            imageView?.image = nil
            $0.removeFromSuperview()
        }
    }
}
