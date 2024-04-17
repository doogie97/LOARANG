//
//  CharacterDetailSkillCell.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class CharacterDetailSkillCell: UITableViewCell {
    private lazy var skillImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        
        return imageView
    }()
    
    //MARK: - Main Skill Info
    private lazy var skillNameLabel = pretendardLabel(size: 16, family: .SemiBold)
    private lazy var skillLevelLabel = pretendardLabel(size: 14, family: .Regular, color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), alignment: .right)
    
    //MARK: - Tripod
    private lazy var tripodSectionView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .mainBackground
        stackView.layer.cornerRadius = 6
        noTripodLabel.isHidden = true
        stackView.addSubview(noTripodLabel)
        noTripodLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
            $0.centerY.equalToSuperview()
        }
        
        return stackView
    }()
    
    private lazy var noTripodLabel = pretendardLabel(size: 12, family: .Regular, text: "장착 트라이포드 없음")
    
    private func setTripodView(_ tripods: [CharacterDetailEntity.Tripod]) {
        noTripodLabel.isHidden = !tripods.isEmpty
        for index in 0..<3 {
            let backView = UIView()
            if let tripod = tripods[safe: index] {
                let levelLabel = pretendardLabel(size: 10, family: .Regular, text: "\(tripod.level) 레벨")
                
                let imageHeight = 25.0
                let imageView = UIImageView()
                imageView.setImage(tripod.imageUrl)
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = imageHeight / 2
                
                let nameLabel = pretendardLabel(size: 12, family: .SemiBold, color: #colorLiteral(red: 1, green: 0.7333333333, blue: 0.3882352941, alpha: 1), text: tripod.name)
                
                backView.addSubview(levelLabel)
                backView.addSubview(imageView)
                backView.addSubview(nameLabel)
                
                levelLabel.snp.makeConstraints {
                    $0.top.leading.equalToSuperview().inset(margin(.width, 10))
                }
                
                imageView.snp.makeConstraints {
                    $0.top.equalTo(levelLabel.snp.bottom).inset(-2)
                    $0.leading.equalToSuperview().inset(margin(.width, 8))
                    $0.height.width.equalTo(imageHeight)
                }
                
                nameLabel.snp.makeConstraints {
                    $0.centerY.equalTo(imageView)
                    $0.leading.equalTo(imageView.snp.trailing).inset(margin(.width, -4))
                    $0.trailing.equalToSuperview().inset(margin(.width, 4))
                }
            }
            
            tripodSectionView.addArrangedSubview(backView)
        }
    }
    
    //MARK: - Rune & Gem
    private lazy var runeLabel = {
        let label = PaddingLabel(top: 8, bottom: 8, left: 8, right: 0)
        label.numberOfLines = 2
        label.font = .pretendard(size: 12, family: .Regular)
        label.backgroundColor = .cellBackgroundColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        return label
    }()
    
    //MARK: - Set Layout
    private lazy var backView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        view.addSubview(skillImageView)
        view.addSubview(skillNameLabel)
        view.addSubview(skillLevelLabel)
        view.addSubview(tripodSectionView)
        view.addSubview(runeLabel)
        
        skillImageView.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.top.leading.equalToSuperview().inset(margin(.width, 10))
        }
        
        skillNameLabel.snp.makeConstraints {
            $0.top.equalTo(skillImageView).inset(2)
            $0.leading.equalTo(skillImageView.snp.trailing).inset(margin(.width, -16))
        }
        
        skillLevelLabel.snp.makeConstraints {
            $0.centerY.equalTo(skillNameLabel)
            $0.trailing.equalToSuperview().inset(margin(.width, 16))
        }
        
        tripodSectionView.snp.makeConstraints {
            $0.top.equalTo(skillImageView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
            $0.height.equalTo(60)
        }
        
        runeLabel.snp.makeConstraints {
            $0.top.equalTo(tripodSectionView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
            $0.bottom.equalToSuperview().inset(30)//다음 뷰로 이동
        }
        
        return view
    }()
    
    func setCellContents(skill: CharacterDetailEntity.Skill) {
        self.selectionStyle = .none
        self.backgroundColor = .mainBackground
        
        skillImageView.setImage(skill.imageUrl)
        skillNameLabel.text = skill.name
        skillLevelLabel.text = "스킬 레벨 " + skill.level.description
        setTripodView(skill.tripods)
        runeLabel.text = skill.rune == nil ? "장착 룬 없음" : "[\(skill.rune?.name ?? "")] \(skill.rune?.tooltip ?? "")"
        runeLabel.asFontColor(targetString: skill.rune?.name ?? "",
                              font: .pretendard(size: 12, family: .Regular),
                              color: skill.rune?.grade.textColor ?? .white)
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skillImageView.kf.cancelDownloadTask()
        skillImageView.image = nil
        tripodSectionView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
