//
//  MianUserTableViewCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

class MianUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var lvNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var itemLvLabel: UILabel!
    
    
    func setCell() {
        topView.layer.cornerRadius = 10
        mainStackView.layer.cornerRadius = 10
        profileImageView.layer.cornerRadius = 60
    }
}
