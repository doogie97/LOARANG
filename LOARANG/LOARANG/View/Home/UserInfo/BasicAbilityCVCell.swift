//
//  BasicAbilityCVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/21.
//

import UIKit

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
    
    private let mainFontSize = CGFloat(18)
    private let subFontSize = CGFloat(15)
    
    func configureInfo(info: BasicAbility) {
        setFont()
        attLabel.text = info.att
        vitalityLabel.text = info.vitality
        critLabel.text = info.crit
        specializationLabel.text = info.specialization
        dominationLabel.text = info.domination
        swiftnessLabel.text = info.swiftness
        enduranceLabel.text = info.endurance
        expertiseLabel.text = info.expertise
    }
    
    private func setFont() {
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
