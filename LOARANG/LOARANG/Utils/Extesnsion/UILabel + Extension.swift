//
//  UILabel + Extension.swift
//  LOARANG
//
//  Created by Doogie on 4/13/24.
//

import UIKit

extension UILabel {
    func asFontColor(targetString: String, font: UIFont?, color: UIColor) {
        let fullText = self.text ?? ""
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText ?? NSMutableAttributedString(string: self.text ?? ""))
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any,
                                        .foregroundColor: color as Any],
                                       range: range)
        self.attributedText = attributedString
    }

}
