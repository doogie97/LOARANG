//
//  CrawlManager.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import Foundation
import SwiftSoup

struct CrawlManager {
    func getUserInfo(userName: String) -> UserInfo? {
        var info: [String] = []
        let urlString = "https://m-lostark.game.onstove.com/Profile/Character/" + userName.changeToPercent()
        guard let url = URL(string: urlString) else { return nil}
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let expeditionLevel22 = try doc.select(".define").select("dd")
            
            for i in expeditionLevel22 {
                info.append(try i.text())
            }
            
            if info.isEmpty { return nil }
            return UserInfo(name: userName, server: info[0], class: info[1], expeditionLevel: info[2], title: info[3], itemLevel: info[4], guild: info[5], pvp: info[6], wisdom: info[7])
        } catch {}
        return nil
    }
}
