//
//  BasicInfoTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/07.
//

import UIKit

class BasicInfoTVCell: UITableViewCell {
    @IBOutlet private weak var basicInfoStackView: UIStackView!
    @IBOutlet private weak var classImageView: UIImageView!
    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var serverLvNameLabel: UILabel!
    @IBOutlet private weak var itemLvLabel: UILabel!
    @IBOutlet private weak var pvpLabel: UILabel!
    @IBOutlet private weak var expLvLabel: UILabel!
    @IBOutlet private weak var battleLvLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var guildLabel: UILabel!
    @IBOutlet private weak var wisdomLabel: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!
    
    private var userInfo: BasicInfo?
    
    func receiveUserInfo(info: BasicInfo) {
        userInfo = info
        configuerInfo()
    }
    
    @IBAction private func touchBookmarkButton(_ sender: UIButton) {
        guard let userInfo = userInfo else { return }
        if BookmarkManager.shared.isContain(name: userInfo.name) {
            BookmarkManager.shared.removeUser(name: userInfo.name)
        } else {
            BookmarkManager.shared.addUser(name: userInfo.name, class: userInfo.class)
        }
        bookmarkButton.setButtonColor(name: userInfo.name)
        NotificationCenter.default.post(name: Notification.Name.bookmark, object: nil)
    }
}
//MARK: - about view
extension BasicInfoTVCell {
    private func configuerInfo() {
        guard let userInfo = userInfo else { return }

        basicInfoStackView.layer.cornerRadius = 10
        classImageView.layer.cornerRadius = classImageView.frame.height / 2.8
        classImageView.image = UIImage(named: userInfo.`class` + "프로필")
        setFont()
        serverLvNameLabel.text = "\(userInfo.server) \(userInfo.name)"
        classLabel.text = userInfo.`class`
        itemLvLabel.text = "아이템 : " + userInfo.itemLevel
        pvpLabel.text = "PVP : " + userInfo.pvp
        expLvLabel.text = "원정대 : " + userInfo.expeditionLevel
        battleLvLabel.text = "전투 레벨 : " + userInfo.battleLevel
        titleLabel.text = "칭호 : " + userInfo.title
        guildLabel.text = "길드 : " + userInfo.guild
        wisdomLabel.text = "영지 : " + userInfo.wisdom
        bookmarkButton.setButtonColor(name: userInfo.name)
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
