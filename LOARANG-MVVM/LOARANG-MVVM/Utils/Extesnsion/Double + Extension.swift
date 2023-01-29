//
//  Double + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/29.
//

import Foundation

extension Double {
    var commaDouble: String {
        let numbuerFormatter = NumberFormatter()
        numbuerFormatter.numberStyle = .decimal
        
        guard let number = numbuerFormatter.string(from: NSNumber(value: self)) else {
            return "-"
        }
        
        return number
    }
}
