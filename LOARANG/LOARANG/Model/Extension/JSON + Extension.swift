//
//  JSON + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

import SwiftyJSON

extension JSON {
    var sortedUp: [JSON] {
        let sortedJson = self.sorted { first, second in
            return first.0 < second.0
        }
        
        let jsonArray = sortedJson.compactMap {
            return $0.1
        }
        
        return jsonArray
    }
    
    var gemInfo: [JSON] {
        let infoJson: [(String, JSON)] = self.compactMap {
            if $0.0.contains("Gem") {
                return $0
            }
            return nil
        }
        
        let sortedJson = infoJson.sorted { first, second in
            return first.0 < second.0
        }
        
        let jsonArray = sortedJson.compactMap {
            return $0.1
        }
        
        return jsonArray
    }
    
    }
}
