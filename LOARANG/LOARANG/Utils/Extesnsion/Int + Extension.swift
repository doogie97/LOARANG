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
            return #colorLiteral(red: 0.05244830996, green: 0.6807646751, blue: 0.03629573435, alpha: 1)
        case 70..<90:
            return #colorLiteral(red: 0.07340445369, green: 0.3782957196, blue: 0.9231976271, alpha: 1)
        case 90..<100:
            return #colorLiteral(red: 0.875810802, green: 0.09193015844, blue: 0.8918681145, alpha: 1)
        case 100:
            return #colorLiteral(red: 0.9174560905, green: 0.4091003239, blue: 0.06985279918, alpha: 1)
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
    
    ///Int를 -> 세 자리 숫자로 변환
    var formattedNumber: String {
            return String(format: "%03d", self)
        }
    
    var commaNumber: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
