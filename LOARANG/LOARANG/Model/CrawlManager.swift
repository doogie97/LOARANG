//
//  CrawlManager.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import Foundation
import SwiftSoup

struct CrawlManager {
    func searchUser(userName: String) throws -> UserInfo {
        let urlString = "https://m-lostark.game.onstove.com/Profile/Character/" + userName.changeToPercent()
        guard let url = URL(string: urlString) else { throw CrawlError.convertError }
        let html = try String(contentsOf: url, encoding: .utf8)
        let doc: Document = try SwiftSoup.parse(html)
        
        let info = try getbainfo(userName: userName, doc: doc)
        
        return UserInfo(basicInfo: info, basicAbility: BasicAbility())
    }
    
    private func getbainfo(userName:String ,doc: Document) throws -> UserBasicInfo {
        var info: [String] = []
        
        let userInfo = try doc.select(".define").select("dd")
        
        for i in userInfo {
            info.append(try i.text())
        }
        
        if info.isEmpty { throw CrawlError.searchError }
        
        let battleLevel = try doc.select(".myinfo__character--button2").select("span").text().replacingOccurrences(of: "Lv.", with: "")
        
        info.append(battleLevel)
        
        return UserBasicInfo(name: userName, server: info[0], class: info[1], expeditionLevel: info[2], title: info[3], itemLevel: info[4], guild: info[6], pvp: info[7], wisdom: info[8], battleLevel: info[9])
    }
    
    
    private func getBasicAbility(url: URL) { //임시임
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let 스탯 = try doc.select(".profile-ability-basic").select("span")
            for i in 스탯 {
                print(try i.text())
            }
            let 각인 = try doc.select(".profile-ability-engrave").select("span").text()
            print(각인)
        } catch {}
    }
}

