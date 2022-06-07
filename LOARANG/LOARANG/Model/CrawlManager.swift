//
//  CrawlManager.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import Foundation
import SwiftSoup

struct CrawlManager {    
    func getBasicInfo(userName: String) -> UserBasicInfo? {
        var info: [String] = []
        let urlString = "https://m-lostark.game.onstove.com/Profile/Character/" + userName.changeToPercent()
        guard let url = URL(string: urlString) else { return nil }
        
        getBasicAbility(url: url)
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let userInfo = try doc.select(".define").select("dd")
            
            for i in userInfo {
                info.append(try i.text())
            }
            let battleLevel = try doc.select(".myinfo__character--button2").select("span").text().replacingOccurrences(of: "Lv.", with: "")
            
            if battleLevel.isEmpty {
                return nil
            }
            
            info.append(battleLevel)
            
            
            if info.isEmpty { return nil }
            
            return UserBasicInfo(name: userName, server: info[0], class: info[1], expeditionLevel: info[2], title: info[3], itemLevel: info[4], guild: info[6], pvp: info[7], wisdom: info[8], battleLevel: info[9])
        } catch {}
        return nil
    }
    
    private func getbainfo(userName:String ,url: URL) -> UserBasicInfo? {
        var info: [String] = []
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let userInfo = try doc.select(".define").select("dd")
            
            for i in userInfo {
                info.append(try i.text())
            }
            let battleLevel = try doc.select(".myinfo__character--button2").select("span").text().replacingOccurrences(of: "Lv.", with: "")
            
            if battleLevel.isEmpty {
                return nil
            }
            
            info.append(battleLevel)
            
            
            if info.isEmpty { return nil }
            
            return UserBasicInfo(name: userName, server: info[0], class: info[1], expeditionLevel: info[2], title: info[3], itemLevel: info[4], guild: info[6], pvp: info[7], wisdom: info[8], battleLevel: info[9])
        } catch {}
        return nil
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
            let 보석 = try doc.select(".jewel_effect").select("strong").text()
            print(각인)
        } catch {}
    }
    
    //profile-ability-tendency
}

