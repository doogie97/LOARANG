//
//  CrawManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import Foundation

struct CralManager {
    static let shared = CralManager()
    private init(){}
    
    func getUserInfo(_ name: String) -> UserInfo {
        //임시 구현
        return fakeUser().user
    }
}
