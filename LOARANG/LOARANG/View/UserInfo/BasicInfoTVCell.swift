//
//  BasicInfoTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/07.
//

import UIKit

class BasicInfoTVCell: UITableViewCell {
    @IBOutlet weak var basicInfoStackView: UIStackView!
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var serverLvNameLabel: UILabel!
    @IBOutlet weak var itemLvLabel: UILabel!
    @IBOutlet weak var pvpLabel: UILabel!
    @IBOutlet weak var expLvLabel: UILabel!
    @IBOutlet weak var battleLvLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var guildLabel: UILabel!
    @IBOutlet weak var wisdomLabel: UILabel!
    
    func configuerInfo(info: BasicInfo) {
        basicInfoStackView.layer.cornerRadius = 10
        classImageView.layer.cornerRadius = classImageView.frame.height / 2.8
        classImageView.image = UIImage(named: "\(info.`class`)프로필")
        setFont()
        serverLvNameLabel.text = "\(info.server) \(info.name)"
        classLabel.text = info.`class`
        itemLvLabel.text = "아이템 : " + info.itemLevel
        pvpLabel.text = "PVP : " + info.pvp
        expLvLabel.text = "원정대 : " + info.expeditionLevel
        battleLvLabel.text = "전투 레벨 : " + info.battleLevel
        titleLabel.text = "칭호 : " + info.title
        guildLabel.text = "길드 : " + info.guild
        wisdomLabel.text = "영지 : " + info.wisdom
    }
    
    private func setFont() {
        serverLvNameLabel.font = UIFont.one(size: 16, family: .Bold)
        classLabel.font = UIFont.one(size: 13, family: .Bold)
        itemLvLabel.font = UIFont.one(size: 13, family: .Bold)
        pvpLabel.font = UIFont.one(size: 13, family: .Bold)
        expLvLabel.font = UIFont.one(size: 13, family: .Bold)
        battleLvLabel.font = UIFont.one(size: 13, family: .Bold)
        titleLabel.font = UIFont.one(size: 13, family: .Bold)
        guildLabel.font = UIFont.one(size: 13, family: .Bold)
        wisdomLabel.font = UIFont.one(size: 13, family: .Bold)
    }
}
