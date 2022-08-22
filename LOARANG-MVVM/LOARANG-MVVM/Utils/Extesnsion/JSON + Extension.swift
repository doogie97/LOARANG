//
//  JSON + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import SwiftyJSON

extension JSON {
    var engraveActivation: Int {
        guard let activation = Int(self.stringValue.components(separatedBy: "+").last?.components(separatedBy: "<").first ?? "")
        else {
            return 0
        }
        
        return activation
    }
}
