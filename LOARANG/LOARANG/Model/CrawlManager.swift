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
        
        let urlString = "https://lostark.game.onstove.com/Profile/Character/" + userName.changeToPercent()
        guard let url = URL(string: urlString) else { return nil}
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let name = try doc.select(".profile-character-info__name").select("span").text()
            let expeditionLevel = try doc.select(".level-info__expedition").select("span").text()
            let battleLevel = try doc.select(".level-info__item").select("span").text()
            let itemLevel = try doc.select(".level-info2__expedition").select("span").text()
            let guild = try doc.select(".game-info__guild").select("span").text()
            let pvpLevel = try doc.select(".level-info__pvp").select("span").text()
            let wisdom = try doc.select(".game-info__wisdom").select("span").text()
            let title = try doc.select(".game-info__title").select("span").text()
            
            return UserInfo(name:name, expeditionLevel: expeditionLevel, battleLevel: battleLevel, itemLevel: itemLevel, title: title, guild: guild, pvpGrade: pvpLevel, wisdom: wisdom)
        } catch {}
        return nil
    }
}
