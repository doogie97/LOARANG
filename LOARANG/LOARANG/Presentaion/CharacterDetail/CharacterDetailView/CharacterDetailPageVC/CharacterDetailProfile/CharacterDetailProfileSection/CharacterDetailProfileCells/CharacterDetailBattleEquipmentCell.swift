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
    
    private lazy var itemLevelLabel = {
        let label = PaddingLabel(top: 0, bottom: 0, left: 8, right: 8)
        label.font = .pretendard(size: 14, family: .SemiBold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        return label
    }()
    
    private lazy var highReforgingLevelLabel = {
        let label = PaddingLabel(top: 0, bottom: 0, left: 8, right: 8)
        label.font = .pretendard(size: 14, family: .SemiBold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.9174560905, green: 0.4091003239, blue: 0.06985279918, alpha: 1)
        return label
    }()
    
    private lazy var nameLabel = pretendardLabel(size: 14, family: .SemiBold)
    
    private lazy var transcendenceView = {
        let view = UIView()
        let imageView = UIImageView(image: UIImage(named: "transcendence.png"))
        view.addSubview(imageView)
        view.addSubview(transcendenceGradeLabel)
        view.addSubview(transcendenceCountLabel)
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(15)
        }
        
        transcendenceGradeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing)
        }
        
        transcendenceCountLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(transcendenceGradeLabel.snp.trailing)
            $0.trailing.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var transcendenceGradeLabel = pretendardLabel(size: 12, family: .SemiBold, color: #colorLiteral(red: 0.9354707008, green: 0.8409317496, blue: 0.6465884395, alpha: 1))
    private lazy var transcendenceCountLabel = pretendardLabel(size: 12, family: .SemiBold)
    
    private lazy var setOptionLabel = {
        let label = PaddingLabel(top: 0, bottom: 0, left: 8, right: 8)
        label.font = .pretendard(size: 12, family: .Bold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        return label
    }()
    
    private lazy var elixirStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = margin(.width, 8)
        
        return stackView
    }()
    
    func setCellContents(equipment: CharacterDetailEntity.Equipment?) {
        if let equipment = equipment {
            self.contentView.backgroundColor = .cellColor
            self.contentView.layer.cornerRadius = 6
            self.isHidden = false
            
            imageView.setImage(equipment.imageUrl)
            imageView.backgroundColor = equipment.grade.backgroundColor
            qualityProgressView.isHidden = equipment.qualityValue < 0
            qualityProgressView.progressTintColor = equipment.qualityValue.qualityColor
            qualityProgressView.progress = Float(equipment.qualityValue)/100
            qualityLabel.text = equipment.qualityValue.description
            equipmentTypeLabel.text = equipment.equipmentType.rawValue
            itemLevelLabel.isHidden = equipment.itemLevel <= 0
            itemLevelLabel.text = "Lv.\(equipment.itemLevel)"
            highReforgingLevelLabel.isHidden = equipment.highReforgingLevel == nil || equipment.highReforgingLevel == 0
            highReforgingLevelLabel.text = "+\(equipment.highReforgingLevel ?? 0)"
            nameLabel.text = equipment.name
            nameLabel.textColor = equipment.grade.textColor
            transcendenceView.isHidden = equipment.transcendence == nil
            transcendenceGradeLabel.text = "Lv.\(equipment.transcendence?.grade ?? 0)"
            transcendenceCountLabel.text = "×\(equipment.transcendence?.count ?? 0)"
            setOptionLabel.text = equipment.setOptionName + " " + equipment.setOptionLevelStr
            addElixirStackView(equipment.elixirs ?? [])
            
            setLayout()
        } else {
            self.isHidden = true
        }
    }
    
    private func addElixirStackView(_ elixirs: [CharacterDetailEntity.Elixir]) {
        elixirStackView.isHidden = elixirs.isEmpty
        for elixir in elixirs {
            let label = PaddingLabel(top: 0, bottom: 0, left: 8, right: 8)
            label.font = .pretendard(size: 12, family: .Bold)
            label.textAlignment = .center
            label.clipsToBounds = true
            label.layer.cornerRadius = 12.5
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.systemGray.cgColor
            label.text = elixir.name + " Lv.\(elixir.level)"
            elixirStackView.addArrangedSubview(label)
        }
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(qualityProgressView)
        self.contentView.addSubview(equipmentTypeLabel)
        self.contentView.addSubview(itemLevelLabel)
        self.contentView.addSubview(highReforgingLevelLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(transcendenceView)
        self.contentView.addSubview(setOptionLabel)
        self.contentView.addSubview(elixirStackView)
        
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
        
        itemLevelLabel.snp.makeConstraints {
            $0.centerY.equalTo(equipmentTypeLabel)
            $0.height.equalTo(22)
            $0.leading.equalTo(equipmentTypeLabel.snp.trailing).inset(margin(.width, -8))
        }
        
        highReforgingLevelLabel.snp.makeConstraints {
            $0.centerY.equalTo(equipmentTypeLabel)
            $0.height.equalTo(22)
            $0.leading.equalTo(itemLevelLabel.snp.trailing).inset(margin(.width, -8))
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(equipmentTypeLabel.snp.bottom).inset(-8)
            $0.leading.equalTo(equipmentTypeLabel)
        }
        
        transcendenceView.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).inset(margin(.width, -4))
        }
        
        setOptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-8)
            $0.height.equalTo(25)
            $0.leading.equalTo(nameLabel)
        }
        
        elixirStackView.snp.makeConstraints {
            $0.centerY.equalTo(setOptionLabel)
            $0.height.equalTo(25)
            $0.leading.equalTo(setOptionLabel.snp.trailing).inset(margin(.width, -8))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        elixirStackView.subviews.forEach { $0.removeFromSuperview() }
    }
}
