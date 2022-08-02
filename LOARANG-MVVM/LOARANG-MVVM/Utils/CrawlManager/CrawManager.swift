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
        guard let basicInfo = try? getBasicInfo(name: name) else {
            completion(.failure(CrawlError.searchError))
            return
        }
        
        completion(.success(UserInfo(basicInfo: basicInfo,
                                     stat: nil,
                                     equips: nil)))
    }
    
    private func makeURL(urlString: String, name: String) -> URL? {
        guard let url = URL(string: urlString + name.changeToPercent()) else {
            return nil
        }
        
        return url
    }
    
    private func makeDocument(url: URL) throws -> Document {
        guard let html = try? String(contentsOf: url, encoding: .utf8) else {
            throw CrawlError.documentError
        }
        
        guard let doc = try? SwiftSoup.parse(html) else {
            throw CrawlError.documentError
        }
        
        return doc
    }
    
    //MARK: - basic info
    private func getBasicInfo(name: String) throws -> BasicInfo {
        guard let url = makeURL(urlString: baseURL, name: name) else {
            throw CrawlError.urlError
        }
        
        guard let doc = try? makeDocument(url: url) else {
            throw CrawlError.documentError
        }
        
        let server = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__user > dl.myinfo__user-names > dd > div.wrapper-define > dl:nth-child(1) > dd").text()
        let name = name
        let battleLV = try doc.select("#myinfo__character--button2 > span").text().replacingOccurrences(of: "Lv.", with: "")
        let itemLV = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(2) > dl.define.item > dd").text()
        let expeditionLV = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(1) > dl:nth-child(1) > dd").text()
        let title = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(1) > dl:nth-child(2) > dd").text()
        let guild = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(3) > dl:nth-child(1) > dd").text()
        let pvp = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(3) > dl:nth-child(2) > dd").text()
        let wisdom = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(4) > dl > dd").text()
        let `class` = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__user > dl.myinfo__user-names > dd > div.wrapper-define > dl:nth-child(2) > dd").text()
        let userImageURL = getUserImageURL(name: name)
        
        return BasicInfo(server: server, name: name, battleLV: battleLV, itemLV: itemLV, expeditionLV: expeditionLV, title: title, guild: guild, pvp: pvp, wisdom: wisdom, class: `class`, userImageURL: userImageURL)
    }
    
    private func getUserImageURL(name: String) -> String {
        let urlString = "https://lostark.game.onstove.com/Profile/Character/"
        guard let url = makeURL(urlString: urlString, name: name) else {
            return ""
        }
        
        guard let doc = try? makeDocument(url: url) else {
            return ""
        }
        
        let imageURL = try? doc.select("#profile-equipment > div.profile-equipment__character > img").attr("src")
        return imageURL ?? ""
    }
}


