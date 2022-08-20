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
    
    private func makeLabel(alignment: NSTextAlignment, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.font = font
        
        return label
    }
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.addSubview(nameLabel)
        self.addSubview(underline)
        self.addSubview(equipmentImageView)
        self.addSubview(partNameLabel)
     
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
    }
    
    func setCellContents(_ equipmentInfo: BattleEquipmentPart) {
        nameLabel.text = equipmentInfo.name?.htmlToString
        nameLabel.textColor = BattleEquipmentPart.Grade(rawValue: equipmentInfo.grade ?? 0)?.textColor
        
        equipmentImageView.setImage(urlString: equipmentInfo.imageURL)
        equipmentImageView.backgroundColor = BattleEquipmentPart.Grade(rawValue: equipmentInfo.grade ?? 0)?.backgroundColor
        print(equipmentInfo.name)
        
        partNameLabel.text = equipmentInfo.part?.htmlToString
        partNameLabel.textColor = BattleEquipmentPart.Grade(rawValue: equipmentInfo.grade ?? 0)?.textColor
    }
}
