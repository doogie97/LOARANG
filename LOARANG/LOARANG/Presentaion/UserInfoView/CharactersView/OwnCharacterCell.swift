//
//  OwnCharacterCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/16.
//

import UIKit
import SnapKit

final class OwnCharacterCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .cellColor
        
        return view
    }()
    
    private lazy var classImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emblem_blade")
        
        return imageView
    }()
    
    private lazy var classLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6069512736, green: 0.7301342378, blue: 1, alpha: 1)
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private lazy var serverLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private lazy var battleLVLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private lazy var itemLVLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: 14, family: .Bold)
        label.textColor = #colorLiteral(red: 1, green: 0.6364469074, blue: 0.3805944694, alpha: 1)
        
        return label
    }()
    
    private lazy var disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        imageView.tintColor = .systemGray3
        imageView.image = UIImage(systemName: "chevron.right")
        
        return imageView
    }()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        self.contentView.addSubview(backView)
        
        backView.addSubview(classImageView)
        backView.addSubview(serverLabel)
        backView.addSubview(classLabel)
        backView.addSubview(userNameLabel)
        backView.addSubview(battleLVLabel)
        backView.addSubview(itemLVLabel)
        backView.addSubview(disclosureIndicator)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
        classImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(40)
            $0.width.equalTo(classImageView.snp.height)
        }
        
        
        serverLabel.snp.makeConstraints {
            $0.bottom.equalTo(userNameLabel.snp.top).inset(-8)
            $0.leading.equalTo(classImageView.snp.trailing).inset(-24)
        }
        
        classLabel.snp.makeConstraints {
            $0.bottom.equalTo(userNameLabel.snp.top).inset(-8)
            $0.leading.equalTo(serverLabel.snp.trailing).inset(-4)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(classImageView.snp.trailing).inset(-24)
        }
        
        battleLVLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).inset(-8)
            $0.leading.equalTo(classImageView.snp.trailing).inset(-24)
        }
        
        itemLVLabel.snp.makeConstraints{
            $0.top.equalTo(userNameLabel.snp.bottom).inset(-8)
            $0.leading.equalTo(battleLVLabel.snp.trailing).inset(-10)
        }
        
        disclosureIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setCellContents(characterInfo: CharacterBasicInfoDTO) {
        _ = classImageView.setImage(urlString: characterInfo.characterClassName?.classImageURL)
        classLabel.text = characterInfo.characterClassName
        serverLabel.text = characterInfo.serverName
        userNameLabel.text = characterInfo.characterName
        battleLVLabel.text = "Lv \(characterInfo.characterLevel ?? 0)"
        itemLVLabel.text = characterInfo.itemAvgLevel
    }
}
