//
//  MianUserTableViewCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

class MianUserTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var lvNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var itemLvLabel: UILabel!
    
    
    func setCell() {
        mainView.layer.cornerRadius = 10
    }
}
