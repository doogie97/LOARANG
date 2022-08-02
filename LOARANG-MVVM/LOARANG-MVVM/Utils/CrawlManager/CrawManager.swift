//
//  CrawManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import Foundation

protocol CrawlManagerable {
    func getUserInfo(_ name: String, completion: (Result<UserInfo, Error>) -> Void)
}

struct CrawlManager: CrawlManagerable {
    func getUserInfo(_ name: String, completion: (Result<UserInfo, Error>) -> Void) {

    }
}
