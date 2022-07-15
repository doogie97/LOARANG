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
        let fakeUsers: [UserInfo] = [fakeUser().user1, fakeUser().user2, fakeUser().user3]
        
        var user: UserInfo?
        fakeUsers.forEach {
            if $0.basicInfo.name == name {
                user = $0
            }
        }
        
        return user ?? fakeUser().user1
    }
}
