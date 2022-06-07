//
//  BasicAbilityTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/07.
//

import UIKit

class BasicAbilityTVCell: UITableViewCell {
    @IBOutlet weak var mainStackView: UIStackView!
    
    func set() {
        mainStackView.layer.cornerRadius = 10
    }
}
