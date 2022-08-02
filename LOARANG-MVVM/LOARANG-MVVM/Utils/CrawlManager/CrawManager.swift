//
//  CrawManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import SwiftSoup

protocol CrawlManagerable {
    func getUserInfo(_ name: String, completion: (Result<UserInfo, Error>) -> Void)
}

struct CrawlManager: CrawlManagerable {
    private let baseURL = "https://m-lostark.game.onstove.com/Profile/Character/"
    
    func getUserInfo(_ name: String, completion: (Result<UserInfo, Error>) -> Void) {
        guard let url = URL(string: baseURL + name.changeToPercent()) else {
            completion(.failure(CrawlError.searchError))
            return
        }
        
        guard let html = try? String(contentsOf: url, encoding: .utf8) else {
            completion(.failure(CrawlError.searchError))
            return
        }
        
        guard let doc = try? SwiftSoup.parse(html) else {
            completion(.failure(CrawlError.searchError))
            return
        }
        
        print(url)
    }
}
