//
//  CharacterDetailBasicInfoCell.swift
//  LOARANG
//
//  Created by Doogie on 4/19/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailBasicInfoCell: UICollectionViewCell {
    private lazy var imageWidth = margin(.width, 150)
    private lazy var characterImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var nameLabel = pretendardLabel(size: 20)
    private lazy var titleLabel = pretendardLabel(size: 12, family: .SemiBold, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    private lazy var serverLabel = {
        let label = PaddingLabel(top: 4, bottom: 4, left: 8, right: 8)
        label.font = .pretendard(size: 12, family: .SemiBold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        return label
    }()
    
    private lazy var classLabel = {
        let label = PaddingLabel(top: 4, bottom: 4, left: 8, right: 8)
        label.font = .pretendard(size: 12, family: .SemiBold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        return label
    }()
    
    private lazy var itemLevelTitleLabel = pretendardLabel(family: .SemiBold, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), text: "아이템", alignment: .center)
    private lazy var battleLevelTitleLabel = pretendardLabel(family: .SemiBold, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), text: "전투", alignment: .center)
    private lazy var expeditionLevelTitleLabel = pretendardLabel(family: .SemiBold, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), text: "원정대", alignment: .center)
    
    private lazy var levelStackView = {
        let itemLevelStackView = equalStackView(arrangedSubviews: [itemLevelTitleLabel,
                                                                   itemLevelLabel],
                                                axix: .vertical, spacing: 5)
        let battleLevelStackView = equalStackView(arrangedSubviews: [battleLevelTitleLabel,
                                                                     battleLevelLabel],
                                                  axix: .vertical, spacing: 5)
        let expeditionLevelStackView = equalStackView(arrangedSubviews: [expeditionLevelTitleLabel,
                                                                         expeditionLevelLabel],
                                                      axix: .vertical, spacing: 5)
        let stackView = equalStackView(arrangedSubviews: [itemLevelStackView,
                                                          battleLevelStackView,
                                                          expeditionLevelStackView],
                                        axix: .horizontal, spacing: 10)
        let view = UIView()
        let backView = UIView()
        backView.backgroundColor = .black
        backView.layer.opacity = 0.4
        backView.layer.cornerRadius = 6
        
        view.addSubview(backView)
        view.addSubview(stackView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(margin(.width, 8))
        }
        
        return view
    }()
    
    private func equalStackView(arrangedSubviews: [UIView], axix: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axix
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        return stackView
    }
    
    private lazy var itemLevelLabel = pretendardLabel(size: 16, alignment: .center)
    private lazy var battleLevelLabel = pretendardLabel(size: 16, alignment: .center)
    private lazy var expeditionLevelLabel = pretendardLabel(size: 16, alignment: .center)
    
    private lazy var guildLabel = pretendardLabel(size: 12, family: .SemiBold)
    private lazy var townLabel = pretendardLabel(size: 12, family: .SemiBold)
    private lazy var pvpLabel = pretendardLabel(size: 12, family: .SemiBold)
    
    private lazy var middleInfoStackView = equalStackView(arrangedSubviews: [middelInfoView(title: "길드", infoLabel: guildLabel),
                                                                             middelInfoView(title: "영지", infoLabel: townLabel),
                                                                             middelInfoView(title: "PVP", infoLabel: pvpLabel)],
                                                          axix: .vertical, spacing: 5)
    
    private func middelInfoView(title: String, infoLabel: UILabel) -> UIView {
        let view = UIView()
        let label = PaddingLabel(top: 4, bottom: 4, left: 8, right: 8)
        label.font = .pretendard(size: 12, family: .SemiBold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        label.text = title
        
        view.addSubview(label)
        view.addSubview(infoLabel)
        label.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(label.snp.trailing).inset(margin(.width, -4))
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        return view
    }
    
    func setCellContents(profile: CharacterDetailEntity.Profile) {
        self.backgroundColor = #colorLiteral(red: 0.07950355858, green: 0.09458512813, blue: 0.1114221141, alpha: 1)
        characterImageView.setImage(profile.imageUrl) {
            self.characterImageView.image = $0.cropImage(characterClass: profile.characterClass, cropCase: .topSqure)
        }
        
        nameLabel.text = profile.characterName
        serverLabel.text = "@" + profile.gameServer.rawValue
        classLabel.text = profile.characterClass.rawValue
        
        guildLabel.text = profile.guildName
        townLabel.text = profile.townName
        pvpLabel.text = profile.pvpGradeName
        
        itemLevelLabel.text = profile.itemLevel.replacingOccurrences(of: ",", with: "")
        battleLevelLabel.text = "Lv.\(profile.battleLevel)"
        expeditionLevelLabel.text = "Lv.\(profile.expeditionLevel)"
        
        titleLabel.text = profile.title
        setLayout(isSpecialist: profile.characterClass == .aeromancer || profile.characterClass == .artist || profile.characterClass.rawValue == "스페셜리스트")
    }
    
    private func setLayout(isSpecialist: Bool) {
        self.contentView.addSubview(characterImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(serverLabel)
        self.contentView.addSubview(classLabel)
        self.contentView.addSubview(titleLabel)
        
        self.contentView.addSubview(middleInfoStackView)
        self.contentView.addSubview(levelStackView)
        
        characterImageView.snp.makeConstraints {
            if isSpecialist {
                $0.leading.equalToSuperview().inset(100)
                $0.trailing.equalToSuperview().inset(-100)
            } else {
                $0.leading.equalToSuperview().inset(50)
                $0.trailing.equalToSuperview().inset(-50)
            }
            $0.top.bottom.equalToSuperview()
        }
        
        nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        nameLabel.setContentHuggingPriority(.required, for: .horizontal)
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(margin(.width, 10))
        }
        
        serverLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).inset(margin(.width, -4))
        }
        
        classLabel.snp.makeConstraints {
            $0.centerY.equalTo(serverLabel)
            $0.trailing.equalToSuperview().inset(margin(.width, 8))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel)
        }
        
        middleInfoStackView.snp.makeConstraints {
            $0.bottom.equalTo(levelStackView.snp.top).inset(-16)
            $0.leading.equalTo(levelStackView)
        }
        
        levelStackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(margin(.width, 8))
        }
    }
}
