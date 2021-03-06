//
//  CrawlManager.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import Foundation
import SwiftSoup

struct CrawlManager {
    static let shared = CrawlManager()
    let baseURL = "https://m-lostark.game.onstove.com/Profile/Character/"
    func searchUser(userName: String) throws -> UserInfo {
        guard let url = URL(string: baseURL + userName.changeToPercent()) else {
            throw CrawlError.convertError
        }
        
        let html = try String(contentsOf: url, encoding: .utf8)
        let doc: Document = try SwiftSoup.parse(html)
        
        if try doc.select("title").text() == "로스트아크 - 서비스 점검" {
            throw CrawlError.inspection
        }
        
        let info = try getBasicInfo(userName: userName, doc: doc)
        let ability = try getBasicAbility(doc: doc)
        let jsonInfo = try getJsonInfo(doc: doc)
        
        return UserInfo(basicInfo: info, basicAbility: ability, userJsonInfo: jsonInfo)
    }
    
    private func getBasicInfo(userName:String ,doc: Document) throws -> BasicInfo {
        var info: [String] = []
        let userInfo = try doc.select(".define").select("dd")
        
        for i in userInfo {
            info.append(try i.text())
        }
        
        if info.isEmpty {
            throw CrawlError.searchError
        }
        
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
    
    private func getInfoJson(doc: Document) throws -> String {
        guard let wholeJsonString = try doc.select("#profile-ability > script").first()?.data() else { throw CrawlError.getJsonError
        }
        let replacedString = wholeJsonString
            .replacingOccurrences(of: "$.Profile = ", with: "")
            .replacingOccurrences(of: ";", with: "")
        return replacedString
    }
    
    private func getJsonInfo(doc: Document) throws -> UserJsonInfo {
        let jsonString = try getInfoJson(doc: doc)
        guard let userJsonInfo = InfoDecoder.shared.decode(info: jsonString) else {
            throw CrawlError.jsonInfoError
        }
        return userJsonInfo
    }
    
    func checkInspection() throws {
        guard let url = URL(string: "https://m-lostark.game.onstove.com") else {
            return
        }
        let html = try String(contentsOf: url, encoding: .utf8)
        let doc: Document = try SwiftSoup.parse(html)
        let title = try doc.select("title").text()
        if title == "로스트아크 - 서비스 점검" {
            throw CrawlError.inspection
        }
    }
}
