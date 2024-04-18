//
//  CharacterDetailOwnCharacterCell.swift
//  LOARANG
//
//  Created by Doogie on 4/18/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailOwnCharacterCell: UITableViewCell {
    private lazy var backView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        view.addSubview(characterClassImageView)
        view.addSubview(characterClassLabel)
        view.addSubview(characterNameLabel)
        view.addSubview(nameSeparator)
        view.addSubview(battleLVLabel)
        view.addSubview(itemLVLabel)
        view.addSubview(rightIndicator)
        
        characterClassImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(40)
            $0.width.equalTo(characterClassImageView.snp.height)
        }
        
        characterClassLabel.snp.makeConstraints {
            $0.bottom.equalTo(characterNameLabel.snp.top).inset(-8)
            $0.leading.equalTo(characterNameLabel)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(characterClassImageView.snp.trailing).inset(margin(.width, -24))
        }
        
        nameSeparator.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.width.equalTo(0.5)
            $0.leading.equalTo(characterNameLabel.snp.trailing).inset(-4)
            $0.centerY.equalToSuperview()
        }
        
        battleLVLabel.snp.makeConstraints {
            $0.centerY.equalTo(characterNameLabel)
            $0.leading.equalTo(nameSeparator.snp.trailing).inset(-4)
        }
        
        itemLVLabel.snp.makeConstraints {
            $0.top.equalTo(characterNameLabel.snp.bottom).inset(-8)
            $0.leading.equalTo(characterNameLabel)
        }
        rightIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        return view
    }()
    private lazy var characterClassImageView = UIImageView()
    
    private lazy var characterNameLabel = pretendardLabel(size: 15, family: .SemiBold)
    private lazy var battleLVLabel = pretendardLabel(size: 12, family: .Regular)
    private lazy var characterClassLabel = pretendardLabel(size: 14, family: .Regular, color: #colorLiteral(red: 0.6069512736, green: 0.7301342378, blue: 1, alpha: 1))
    private lazy var itemLVLabel = pretendardLabel(size: 15, family: .SemiBold, color: #colorLiteral(red: 1, green: 0.6364469074, blue: 0.3805944694, alpha: 1))
    
    private lazy var nameSeparator = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private lazy var rightIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold)
        imageView.tintColor = .systemGray3
        imageView.image = UIImage(systemName: "chevron.right")
        
        return imageView
    }()
    
    func setCellContents(_ character: OwnCharactersEntity.Character) {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        characterClassImageView.setImage(character.characterClass.classImageURL)
        characterNameLabel.text = character.characterName
        characterClassLabel.text = character.characterClass.rawValue
        battleLVLabel.text = "Lv" + character.battelLevel.description
        itemLVLabel.text = character.itemLevel
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            let inset = margin(.width, 8)
            $0.top.leading.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterClassImageView.kf.cancelDownloadTask()
        characterClassImageView.image = nil
    }
}
