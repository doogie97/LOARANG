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
    
    func getInfo(of: String) -> [JSON] {
        let infoJson: [JSON] = self.compactMap { (String, JSON) in
            if String.contains(of) {
                return JSON
            }
            return nil
        }
        return infoJson
    }
}
