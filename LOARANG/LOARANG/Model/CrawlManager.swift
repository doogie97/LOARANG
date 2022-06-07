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
        let ability = try getBasicAbility(doc: doc)
        return UserInfo(basicInfo: info, basicAbility: ability)
    }
    
    private func getbainfo(userName:String ,doc: Document) throws -> BasicInfo {
        var info: [String] = []
        let userInfo = try doc.select(".define").select("dd")
        
        for i in userInfo {
            info.append(try i.text())
        }
        
        if info.isEmpty { throw CrawlError.searchError }
        
        let battleLevel = try doc.select(".myinfo__character--button2").select("span").text().replacingOccurrences(of: "Lv.", with: "")
        
        info.append(battleLevel)
        
        return BasicInfo(name: userName, server: info[0], class: info[1], expeditionLevel: info[2], title: info[3], itemLevel: info[4], guild: info[6], pvp: info[7], wisdom: info[8], battleLevel: info[9])
    }
    
    private func getBasicAbility(doc: Document) throws -> BasicAbility {
        var ability: [String] = []
        let userAbility = try doc.select(".profile-ability-basic").select("span")
        
        for i in userAbility {
            ability.append(try i.text())
        }
        
        if ability.isEmpty {
        return BasicAbility(att: "0", vitality: "0", crit: "0", specialization: "0", domination: "0", swiftness: "0", endurance: "0", expertise: "0")
        }
        
        return BasicAbility(att: ability[1], vitality: ability[3], crit: ability[5], specialization: ability[7], domination: ability[9], swiftness: ability[11], endurance: ability[13], expertise: ability[15])
    }
}
