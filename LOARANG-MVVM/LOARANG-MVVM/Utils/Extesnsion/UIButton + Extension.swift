//
//  UIButton + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import UIKit

extension UIButton {
    func setBookmarkButtonColor(_ isBookmark: Bool) {
        if isBookmark {
            let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            self.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        } else {
            let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            self.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}
