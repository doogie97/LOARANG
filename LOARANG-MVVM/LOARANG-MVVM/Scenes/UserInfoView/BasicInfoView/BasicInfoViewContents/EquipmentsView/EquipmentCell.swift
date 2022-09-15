//
//  EquipmentCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/19.
//

import SnapKit

final class EquipmentCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        label.font = .one(size: 12, family: .Bold)
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 12, family: .Bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .left
        
        return label
    }()
    
    func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellColor

        self.contentView.addSubview(partImageView)
        self.contentView.addSubview(partLabel)
        self.contentView.addSubview(nameLabel)

        
        partImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(partImageView.snp.width)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(safeAreaLayoutGuide)
        }
        
        partLabel.snp.makeConstraints {
            $0.leading.equalTo(partImageView.snp.trailing).inset(-5)
            $0.top.equalTo(partImageView.snp.top).inset(5)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(partImageView.snp.trailing).inset(-5)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(partImageView.snp.centerY)
        }
    }
    
    func setCellContents(equipmentPart: EquipmentPart?, partString: String?, backColor: UIColor?) {
        partImageView.setImage(urlString: equipmentPart?.basicInfo.imageURL)
        partImageView.backgroundColor = backColor
        partLabel.text = partString
        nameLabel.text = equipmentPart?.basicInfo.name?.htmlToString
        nameLabel.textColor = Equips.Grade(rawValue: equipmentPart?.basicInfo.grade ?? 0)?.textColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        partImageView.image = UIImage(named: "장비기본이미지")
    }
}
