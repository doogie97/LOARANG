//
//  CrawlManager.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import Foundation
import SwiftSoup

struct CrawlManager {
    func getCharacterTitle(userName: String) -> String {
        
        let urlString = "https://lostark.game.onstove.com/Profile/Character/" + userName.changeToPercent()
        guard let url = URL(string: urlString) else { return "실패"}
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let characterTitle: Elements = try doc.select(".game-info__title").select("span")
            let titleText = try characterTitle.text()
            return titleText
        } catch {
            print("error")
        }
        return "실패"
    }
}
