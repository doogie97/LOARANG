//
//  UIFont + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit

extension UIFont {
    enum Family: String {
        case Bold, Light, Regular, Title
    }
    
    static func one(size: CGFloat, family: Family) -> UIFont {
        return UIFont(name: "ONEMobile\(family)", size: size) ?? UIFont()
    }
    
    static func BlackHanSans(size: CGFloat) -> UIFont {
        return UIFont(name: "BlackHanSans-Regular", size: size) ?? UIFont()
    }
}
