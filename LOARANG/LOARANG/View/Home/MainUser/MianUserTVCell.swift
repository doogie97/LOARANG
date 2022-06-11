//
//  MianUserTableViewCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

class MianUserTVCell: UITableViewCell {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var lvNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var classInfoLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemLvLabel: UILabel!
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var serverInfoLabel: UILabel!
    
    
    func setCell() {
        setCharacterInfo()
        setCorner()
        setLabelFont()
    }
    
    private func setCorner() {
        topView.layer.cornerRadius = 10
        mainStackView.layer.cornerRadius = 10
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.8
    }
    
    private func setCharacterInfo() {
        guard let userName = UserDefaults.standard.string(forKey: "mainCharacter") else { return }
        guard let basicInfo = try? CrawlManager.shared.searchUser(userName: userName).basicInfo else { return }
        profileImageView.image = UIImage(named: basicInfo.class + "프로필")
        lvNameLabel.text = "Lv \(basicInfo.battleLevel) \(basicInfo.name)"
        classInfoLabel.text = basicInfo.`class`
        itemLvLabel.text = basicInfo.itemLevel
        serverInfoLabel.text = basicInfo.server
    }
    
    private func setLabelFont() {
        lvNameLabel.font = UIFont.one(size: 18, family: .Bold)
        lvNameLabel.textColor = .white
        classLabel.font = UIFont.one(size: 15, family: .Bold)
        classLabel.textColor = .white
        classInfoLabel.font = UIFont.one(size: 15, family: .Bold)
        classInfoLabel.textColor = .white
        itemLabel.font = UIFont.one(size: 15, family: .Bold)
        itemLabel.textColor = .white
        itemLvLabel.font = UIFont.one(size: 15, family: .Bold)
        itemLvLabel.textColor = .white
        serverLabel.font = UIFont.one(size: 15, family: .Bold)
        serverLabel.textColor = .white
        serverInfoLabel.font = UIFont.one(size: 15, family: .Bold)
        serverInfoLabel.textColor = .white
    }
}
