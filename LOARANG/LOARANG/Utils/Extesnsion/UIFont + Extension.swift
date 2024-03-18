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
    
    static func one(size: Int, family: Family) -> UIFont {
        return UIFont(name: "ONEMobile\(family)", size: CGFloat(size)) ?? UIFont()
    }
    
    static func BlackHanSans(size: Int) -> UIFont {
        return UIFont(name: "BlackHanSans-Regular", size: CGFloat(size)) ?? UIFont()
    }
}
