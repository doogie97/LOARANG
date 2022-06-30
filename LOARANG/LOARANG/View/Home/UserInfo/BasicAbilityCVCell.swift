//
//  BasicAbilityCVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/21.
//

import UIKit
//MARK: - properties
class BasicAbilityCVCell: UICollectionViewCell {
    @IBOutlet weak var attTitleLabel: UILabel!
    @IBOutlet weak var vitalityTitleLabel: UILabel!
    @IBOutlet weak var critTitleLabel: UILabel!
    @IBOutlet weak var specializationTitleLabel: UILabel!
    @IBOutlet weak var dominationTitleLabel: UILabel!
    @IBOutlet weak var swiftnessTitleLabel: UILabel!
    @IBOutlet weak var enduranceTitleLabel: UILabel!
    @IBOutlet weak var expertiseTitleLabel: UILabel!
    
    @IBOutlet weak var attLabel: UILabel!
    @IBOutlet weak var vitalityLabel: UILabel!
    @IBOutlet weak var critLabel: UILabel!
    @IBOutlet weak var specializationLabel: UILabel!
    @IBOutlet weak var dominationLabel: UILabel!
    @IBOutlet weak var swiftnessLabel: UILabel!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var expertiseLabel: UILabel!
    
    @IBOutlet weak var gemStackView: UIStackView!
    
}
//MARK: - method
extension BasicAbilityCVCell {
    func configureInfo(info: UserInfo) {
        setFont()
        setBasicAbility(info.basicAbility)
        setGem(info.userJsonInfo.equipmenInfo.gems)
    }
    
    private func setBasicAbility(_ info: BasicAbility) {
        attLabel.text = info.att
        vitalityLabel.text = info.vitality
        critLabel.text = info.crit
        specializationLabel.text = info.specialization
        dominationLabel.text = info.domination
        swiftnessLabel.text = info.swiftness
        enduranceLabel.text = info.endurance
        expertiseLabel.text = info.expertise
    }
    
    private func setGem(_ gems: [Gem]) {
        if gems.isEmpty {
            gemStackView.addArrangedSubview(noGemLabel())
            return
        }
        
        if gems.count <= 6 {
            gemStackView.addArrangedSubview(insideGemStackView(gems))
        }
        overSixGemStackView(gems)
    }
}

// MARK: - make view
extension BasicAbilityCVCell {
    private func noGemLabel() -> UILabel {
        let label = UILabel()
        label.text = "장착된 보석이 없습니다"
        label.font = UIFont.one(size: 22, family: .Bold)
        label.textColor = .white
        
        return label
    }
    
    private func gemImageView(_ gem: Gem) -> UIImageView {
        let imageView = UIImageView()
        imageView.setImage(gem.imageURL)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func insideGemStackView(_ gems: [Gem]) -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        
        for i in 0...gems.count - 1 {
            stackView.addArrangedSubview(gemImageView(gems[i]))
        }
        
        if 6 - gems.count != 0 {
            for _ in 1...6 - gems.count{
                stackView.addArrangedSubview(UIImageView())
            }
            
        }
        
        return stackView
    }
    
    private func overSixGemStackView(_ gems: [Gem]) {
        var firstGems: [Gem] = []
        var secondGems = gems
        for _ in 0...5 {
            guard let gem = secondGems.popFirst() else {
                return
            }
            firstGems.append(gem)
        }
        
        gemStackView.addArrangedSubview(insideGemStackView(firstGems))
        gemStackView.addArrangedSubview(insideGemStackView(secondGems))
    }
}

//MARK: - font Setting
extension BasicAbilityCVCell {
    private func setFont() {
        let mainFontSize = CGFloat(18)
        let subFontSize = CGFloat(15)
        
        attTitleLabel.font = UIFont.one(size: mainFontSize, family: .Bold)
        vitalityTitleLabel.font = UIFont.one(size: mainFontSize, family: .Bold)
        critTitleLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        specializationTitleLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        dominationTitleLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        swiftnessTitleLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        enduranceTitleLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        expertiseTitleLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        
        attLabel.font = UIFont.one(size: mainFontSize, family: .Bold)
        vitalityLabel.font = UIFont.one(size: mainFontSize, family: .Bold)
        critLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        specializationLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        dominationLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        swiftnessLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        enduranceLabel.font = UIFont.one(size: subFontSize, family: .Bold)
        expertiseLabel.font = UIFont.one(size: subFontSize, family: .Bold)
    }
}
