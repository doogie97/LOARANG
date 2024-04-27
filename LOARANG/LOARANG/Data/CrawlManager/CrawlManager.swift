//
//  CrawlManager.swift
//  LOARANG
//
//  Created by Doogie on 4/17/24.
//

import SwiftSoup
import Foundation
import SwiftyJSON
import Alamofire

protocol CrawlManagerable {
    func getSkillInfo(_ name: String) async throws -> SkillInfo
}

final class CrawlManager: CrawlManagerable {
    private let jsonManger: JsonInfoManagerable = JsonInfoManager()
    private let baseURL = "https://m-lostark.game.onstove.com/Profile/Character/"
    
    private func makeDocument(name: String) async throws -> Document {
        guard let url = URL(string: baseURL + name.changeToPercent()) else {
            throw CrawlError.urlError
        }
        
        let response = await AF.request(url).serializingString().response
        
        guard let html = response.value,
              let doc = try? SwiftSoup.parse(html) else {
            throw CrawlError.documentError
        }
        
        return doc
    }
    
    private func wholeJsonString(doc: Document) throws -> String {
        guard let wholeJsonString = try? doc.select("#profile-ability > script").first()?.data() else {
            throw CrawlError.jsonInfoError
        }
        
        let replacedString = wholeJsonString
            .replacingOccurrences(of: "$.Profile = ", with: "")
            .replacingOccurrences(of: ";", with: "")
        
        return replacedString
    }
    
    //MARK: SkillInfo
    func getSkillInfo(_ name: String) async throws -> SkillInfo {
        let doc = try await makeDocument(name: name)
        guard let wholeJsonString = try? wholeJsonString(doc: doc) else {
            throw CrawlError.getSkillError
        }
        
        let usedSkillPoint = try? doc.select("#profile-skill-battle > div > div.profile-skill__point > em:nth-child(2)").text()
        let totalSkillPoint = try? doc.select("#profile-skill-battle > div > div.profile-skill__point > em:nth-child(4)").text()
        
        let skills = jsonManger.getSkills(jsonString: wholeJsonString)
        return SkillInfo(usedSkillPoint: usedSkillPoint ?? "-",
                         totalSkillPoint: totalSkillPoint ?? "-",
                         skills: skills)
    }
}
