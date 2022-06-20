//
//  InfoPageViewTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

import UIKit

class InfoPageViewTVCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func touchStatButton(_ sender: UIButton) {
        print("특성")
    }
    @IBAction func touchCardButton(_ sender: UIButton) {
        print("카드")
    }
    
}
