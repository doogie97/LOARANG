//
//  CharacterDetailBattleEquipmentCell.swift
//  LOARANG
//
//  Created by Doogie on 4/19/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailBattleEquipmentCell: UICollectionViewCell {
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    private lazy var qualityProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = .cellBackgroundColor
        progressView.progressViewStyle = .bar
        progressView.layer.borderWidth = 0.5
        progressView.layer.borderColor = UIColor.systemGray.cgColor
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 6
        progressView.addSubview(qualityLabel)
        qualityLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return progressView
    }()
    
    private lazy var qualityLabel = pretendardLabel(size: 10, family: .SemiBold, alignment: .center)
    
    private lazy var equipmentTypeLabel = pretendardLabel(size: 14, family: .SemiBold)
    private lazy var nameLabel = pretendardLabel(size: 14, family: .SemiBold)
    
    private lazy var setOptionLabel = {
        let label = PaddingLabel(top: 0, bottom: 0, left: 8, right: 8)
        label.font = .pretendard(size: 12, family: .Bold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        return label
    }()
    func setCellContents(equipment: CharacterDetailEntity.Equipment) {
        self.contentView.backgroundColor = .cellColor
        self.contentView.layer.cornerRadius = 6
        
        imageView.setImage(equipment.imageUrl)
        imageView.backgroundColor = equipment.grade.backgroundColor
        qualityProgressView.progressTintColor = equipment.qualityValue.qualityColor
        qualityProgressView.progress = Float(equipment.qualityValue)/100
        qualityLabel.text = equipment.qualityValue.description
        equipmentTypeLabel.text = equipment.itemTypeTitle
        nameLabel.text = equipment.name
        nameLabel.textColor = equipment.grade.textColor
        setOptionLabel.text = equipment.setOptionName + " " + equipment.setOptionLevelStr
        
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(qualityProgressView)
        self.contentView.addSubview(equipmentTypeLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(setOptionLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(margin(.width, 10))
            $0.bottom.equalTo(qualityProgressView.snp.top).inset(margin(.width, -8))
            $0.width.equalTo(imageView.snp.height)
        }
        
        qualityProgressView.snp.makeConstraints {
            $0.leading.trailing.equalTo(imageView).inset(-2)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(14)
        }
        
        equipmentTypeLabel.snp.makeConstraints {
            $0.top.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).inset(margin(.width, -16))
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(equipmentTypeLabel.snp.bottom).inset(-8)
            $0.leading.equalTo(equipmentTypeLabel)
        }
        
        setOptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-8)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(nameLabel)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}
