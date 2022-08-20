//
//  EquipmentDetailView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/20.
//

import SnapKit

final class EquipmentDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return button
    }()
    
    private lazy var nameLabel = makeLabel(alignment: .center, font: .one(size: 20, family: .Bold))
    
    private lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    private lazy var equipmentImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var partNameLabel = makeLabel(alignment: .left, font: .one(size: 15, family: .Bold))
    
    private lazy var itemLvLabel = makeLabel(alignment: .left, font: .one(size: 18, family: .Bold))
    
    private lazy var qualityLabel = makeLabel(alignment: .left, font: .one(size: 15, family: .Bold))
    
    private lazy var qualityBar: UIView = { //나중에 게이지 바로 바꿀 예정
        let view = UIView()
        view.backgroundColor = .systemOrange
        
        return view
    }()
    private lazy var effetcTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = backgroundColor
        textView.isEditable = false
        
        return textView
    }()
    
    private func makeLabel(alignment: NSTextAlignment, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.font = font
        
        return label
    }
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.addSubview(closeButton)
        self.addSubview(nameLabel)
        self.addSubview(underline)
        self.addSubview(equipmentImageView)
        self.addSubview(partNameLabel)
        self.addSubview(itemLvLabel)
        self.addSubview(qualityLabel)
        self.addSubview(qualityBar) // 나중에 제대로 구현 필요
        self.addSubview(effetcTextView)
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(15)
            $0.centerY.equalTo(nameLabel)
            $0.height.width.equalTo(30)
        }
     
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        underline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-15)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        equipmentImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(equipmentImageView.snp.width)
            $0.top.equalTo(underline.snp.bottom).inset(-20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        partNameLabel.snp.makeConstraints {
            $0.leading.equalTo(equipmentImageView.snp.trailing).inset(-15)
            $0.top.equalTo(equipmentImageView.snp.top)
        }
        
        itemLvLabel.snp.makeConstraints {
            $0.leading.equalTo(equipmentImageView.snp.trailing).inset(-15)
            $0.centerY.equalTo(equipmentImageView.snp.centerY)
        }
        
        qualityLabel.snp.makeConstraints {
            $0.leading.equalTo(equipmentImageView.snp.trailing).inset(-15)
            $0.bottom.equalTo(equipmentImageView.snp.bottom)
        }
        
        qualityBar.snp.makeConstraints {
            $0.top.equalTo(qualityLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(equipmentImageView).multipliedBy(0.35)
        }
        
        effetcTextView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(qualityBar.snp.bottom).inset(-16)
        }
    }
    
    func setCellContents(_ equipmentInfo: BattleEquipmentPart) {
        nameLabel.text = equipmentInfo.name?.htmlToString
        nameLabel.textColor = BattleEquipmentPart.Grade(rawValue: equipmentInfo.grade ?? 0)?.textColor
        
        equipmentImageView.setImage(urlString: equipmentInfo.imageURL)
        equipmentImageView.backgroundColor = BattleEquipmentPart.Grade(rawValue: equipmentInfo.grade ?? 0)?.backgroundColor
        
        partNameLabel.text = equipmentInfo.part?.htmlToString
        partNameLabel.textColor = BattleEquipmentPart.Grade(rawValue: equipmentInfo.grade ?? 0)?.textColor
        
        itemLvLabel.text = equipmentInfo.lv?.htmlToString
        
        qualityLabel.text = "품질 \(equipmentInfo.quality ?? 0)"
        
        effetcTextView.attributedText = equipmentInfo.battleEffects?.htmlToAttributedString(fontSize: 5)
    }
}
