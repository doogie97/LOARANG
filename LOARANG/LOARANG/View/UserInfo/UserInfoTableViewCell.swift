//
//  UserInfoTableViewCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

final class UserInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var infoLabel: UILabel!
    
    func showInfo(info: String) {
        infoLabel.text = info
    }
}
