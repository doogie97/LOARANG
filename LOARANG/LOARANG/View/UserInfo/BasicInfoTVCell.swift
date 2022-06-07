//
//  BasicInfoTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/07.
//

import UIKit

class BasicInfoTVCell: UITableViewCell {
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var serverLvNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var itemLvLabel: UILabel!
    @IBOutlet weak var expLvLabel: UILabel!
    @IBOutlet weak var pvpLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var guildLabel: UILabel!
    @IBOutlet weak var wisdomLabel: UILabel!
    
    func configuerInfo(info: UserBasicInfo) {
        setFont()
        classImageView.layer.cornerRadius = classImageView.frame.height / 2.5
        serverLvNameLabel.text = info.server + " LV." + info.battleLevel + info.name
        classLabel.text = info.`class`
        itemLvLabel.text = info.itemLevel
        expLvLabel.text = info.expeditionLevel
        pvpLabel.text = info.pvp
        titleLabel.text = info.title
        guildLabel.text = info.guild
        wisdomLabel.text = info.wisdom
    }
    
    private func setFont() {
        serverLvNameLabel.font = UIFont.one(size: 16, family: .Bold)
        classLabel.font = UIFont.one(size: 16, family: .Bold)
        itemLvLabel.font = UIFont.one(size: 16, family: .Bold)
        expLvLabel.font = UIFont.one(size: 16, family: .Bold)
        pvpLabel.font = UIFont.one(size: 16, family: .Bold)
        titleLabel.font = UIFont.one(size: 16, family: .Bold)
        guildLabel.font = UIFont.one(size: 16, family: .Bold)
        wisdomLabel.font = UIFont.one(size: 16, family: .Bold)
    }
}
