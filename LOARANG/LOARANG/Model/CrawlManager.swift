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
            
            let userInfo = try doc.select(".define").select("dd")
            
            for i in userInfo {
                info.append(try i.text())
            }
            let battleLevel = try doc.select(".myinfo__character--button2").select("span").text().replacingOccurrences(of: "Lv.", with: "")
            
            info.append(battleLevel)
            
            
            if info.isEmpty { return nil }
            return UserInfo(name: userName, server: info[0], class: info[1], expeditionLevel: info[2], title: info[3], itemLevel: info[4], guild: info[6], pvp: info[7], wisdom: info[8], battleLevel: info[9])
        } catch {}
        return nil
    }
}
