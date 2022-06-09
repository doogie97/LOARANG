//
//  SettingTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/09.
//

import UIKit

class SettingTVCell: UITableViewCell {
    @IBOutlet weak var menuTitleLabel: UILabel!
    
    func configureCell(title: String) {
        menuTitleLabel.text = title
    }
}
