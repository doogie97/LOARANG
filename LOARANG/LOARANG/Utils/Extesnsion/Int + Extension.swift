//
//  Int + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/20.
//

import UIKit

extension Int {
    var qualityColor: UIColor {
        switch self {
        case 10..<30:
            return #colorLiteral(red: 1, green: 0.82471174, blue: 0, alpha: 1)
        case 30..<70:
            return #colorLiteral(red: 0.561450541, green: 0.9948626161, blue: 0, alpha: 1)
        case 70..<90:
            return #colorLiteral(red: 0.007898607291, green: 0.7087070346, blue: 1, alpha: 1)
        case 90..<100:
            return #colorLiteral(red: 0.8060045242, green: 0.261687547, blue: 0.9900844693, alpha: 1)
        case 100:
            return #colorLiteral(red: 0.9972185493, green: 0.5881507397, blue: 0.007285744417, alpha: 1)
        default:
            return #colorLiteral(red: 0.7534232736, green: 0.001419665525, blue: 0.009936906397, alpha: 1)
        }
    }
    var engravingHeight: CGFloat {
        switch self {
        case 0:
            return UIScreen.main.bounds.width * 0.12
        case 1...2:
            return UIScreen.main.bounds.width * 0.1
        case 3...4:
            return UIScreen.main.bounds.width * 0.17
        case 5...6:
            return UIScreen.main.bounds.width * 0.24
        case 7...8:
            return UIScreen.main.bounds.width * 0.31
        default:
            return UIScreen.main.bounds.width * 0.38
        }
    }
}
