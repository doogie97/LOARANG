//
//  SpecialEquipmentCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/23.
//

import SnapKit

final class SpecialEquipmentCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var partImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "장비기본이미지")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    private lazy var partLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 15, family: .Bold)
        
        return label
    }()

    func setLayout() {
        self.backgroundColor = .cellColor

        self.contentView.addSubview(partImageView)
        self.contentView.addSubview(partLabel)

        partImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.43)
            $0.height.equalTo(partImageView.snp.width)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(safeAreaLayoutGuide)
        }
        
        partLabel.snp.makeConstraints {
            $0.leading.equalTo(partImageView.snp.trailing).inset(-10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setCellContents(equipmentPart: EquipmentPart?, partString: String?, backColor: UIColor?) {
        partImageView.setImage(urlString: equipmentPart?.basicInfo.imageURL)
        partImageView.backgroundColor = backColor
        partLabel.text = partString
    }
}
