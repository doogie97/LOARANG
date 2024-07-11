//
//  LOARANG++Bundle.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation

extension Bundle {
    var lostarkApiKeyArray: [String] {
        guard let filePath = self.path(forResource: "AppPrivacyInfo", ofType: "plist") else {
            fatalError("API Key를 확인해 주세요")
        }
        
        guard let resource = NSDictionary(contentsOfFile: filePath) else {
            fatalError("API Key를 확인해 주세요")
        }
        
        guard let apiKeys = resource["Lostark_API_Key_Array"] as? [String] else {
            fatalError("API Key를 확인해 주세요")
        }
        
        guard let _ = apiKeys.first else {
            fatalError("API Key를 확인해 주세요")
        }
        
        return apiKeys
    }
    
    var mixpanelToken: String? {
        guard let filePath = self.path(forResource: "AppPrivacyInfo", ofType: "plist") else {
            return nil
        }
        
        guard let resource = NSDictionary(contentsOfFile: filePath) else {
            return nil
        }
        
        return resource["MixpanelKey"] as? String
    }
}
