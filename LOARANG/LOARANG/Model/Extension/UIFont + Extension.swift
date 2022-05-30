//
//  UIFont + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/30.
//

import UIKit

extension UIFont {
    
    enum Family: String {
        case Bold, Light, Regular
    }
    
    static func one(size: CGFloat, family: Family) -> UIFont! {
        return UIFont(name: "ONEMobile\(family)", size: size)
    }
}
