//
//  LOARANG++Bundle.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation

extension Bundle {
    var lostarkAPIKey: String {
        guard let filePath = self.path(forResource: "AppPrivacyInfo", ofType: "plist") else {
            return ""
        }
        
        guard let resource = NSDictionary(contentsOfFile: filePath) else {
            return ""
        }
        
        guard let apiKey = resource["Lostark_API_Key"] as? String else {
            fatalError("API Key를 확인해 주세요")
        }
        
        if apiKey == "Please_enter_the_API-Key" {
            fatalError("API Key를 확인해 주세요")
        }
        
        return apiKey
    }
}
