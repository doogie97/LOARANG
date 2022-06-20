//
//  InfoPageViewTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

import UIKit

class InfoPageViewTVCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var menuStackView: UIStackView!
    
    func setInitailView() {
        mainView.layer.cornerRadius = 10
        pageView.layer.cornerRadius = 10
        menuStackView.layer.cornerRadius = 10
    }
    
    @IBAction func touchStatButton(_ sender: UIButton) {
        print("특성")
    }
    @IBAction func touchCardButton(_ sender: UIButton) {
        print("카드")
    }
    
}
