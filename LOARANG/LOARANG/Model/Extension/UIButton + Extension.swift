//
//  UIButton + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/08.
//

import UIKit

extension UIButton {
    func setButtonColor(name: String) {
        if BookmarkManager.shared.isContain(name: name) {
            let buttonImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            self.setImage(buttonImage, for: .normal)
            self.tintColor = #colorLiteral(red: 0.8941176471, green: 1, blue: 0.5333333333, alpha: 1)
        } else {
            let buttonImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
            self.setImage(buttonImage, for: .normal)
            self.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
}
