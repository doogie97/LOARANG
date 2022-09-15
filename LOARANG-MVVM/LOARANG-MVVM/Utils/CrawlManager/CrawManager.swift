//
//  CrawManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import SwiftSoup

protocol CrawlManagerable {
    func getUserInfo(_ name: String, completion: @escaping (Result<UserInfo, Error>) -> Void)
    func chenckInspection() throws
}

struct CrawlManager: CrawlManagerable {
    private let baseURL = "https://m-lostark.game.onstove.com/Profile/Character/"
    
    func getUserInfo(_ name: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        DispatchQueue.global().async {
            guard let url = makeURL(urlString: baseURL, name: name) else {
                DispatchQueue.main.async {
                completion(.failure(CrawlError.urlError))
                }
                return
            }
            
            guard let doc = try? makeDocument(url: url) else {
                DispatchQueue.main.async {
                completion(.failure(CrawlError.documentError))
                }
                return
            }

            guard let stat = try? getStat(doc: doc) else {
                DispatchQueue.main.async {
                completion(.failure(CrawlError.searchError))
                }
                return
            }
            
            guard let userJsonInfo = try? getUserJsonInfo(doc: doc) else {
                DispatchQueue.main.async {
                completion(.failure(CrawlError.searchError))
                }
                return
            }
            
            getMainInfo(name: name, doc: doc) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let mainInfo):
                        completion(.success(UserInfo(mainInfo: mainInfo,
                                                     stat: stat,
                                                     userJsonInfo: userJsonInfo)))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
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
    private func getMainInfo(name: String, doc: Document, completion: @escaping (Result<MainInfo, Error>) -> Void) {
        
        do {
            let server = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__user > dl.myinfo__user-names > dd > div.wrapper-define > dl:nth-child(1) > dd").text()
            
            if server == "" {
                throw CrawlError.searchError
            }
            
            let name = name
            let battleLV = try doc.select("#myinfo__character--button2 > span").text().replacingOccurrences(of: "Lv.", with: "")
            let itemLV = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(2) > dl.define.item > dd").text()
            let expeditionLV = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(1) > dl:nth-child(1) > dd").text()
            let title = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(1) > dl:nth-child(2) > dd").text()
            let guild = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(3) > dl:nth-child(1) > dd").text()
            let pvp = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(3) > dl:nth-child(2) > dd").text()
            let wisdom = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__contents-level > div:nth-child(4) > dl > dd").text()
            let `class` = try doc.select("#lostark-wrapper > div > main > div > div > div.myinfo__contents-character > div.myinfo__user > dl.myinfo__user-names > dd > div.wrapper-define > dl:nth-child(2) > dd").text()
            
            getUserImage(name: name) { image in
                completion(.success(MainInfo(server: server, name: name, battleLV: battleLV, itemLV: itemLV, expeditionLV: expeditionLV, title: title, guild: guild, pvp: pvp, wisdom: wisdom, class: `class`, userImage: image)))
            }
        } catch {
            completion(.failure(CrawlError.searchError))
        }
    }
    
    private func getUserImage(name: String, completion: @escaping (UIImage) -> Void) {
        let urlString = "https://lostark.game.onstove.com/Profile/Character/"
        guard let url = makeURL(urlString: urlString, name: name),
              let doc = try? makeDocument(url: url),
              let imageURL = try? doc.select("#profile-equipment > div.profile-equipment__character > img").attr("src"),
              let url = URL(string: imageURL) else {
            completion(UIImage())
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(UIImage())
                return
            }
            completion(UIImage(data: data) ?? UIImage())
        }
        dataTask.resume()
        // 빈 이미지 리턴 하는 부분은 추후 이미지 다운 실패이미지로 변경 필요
    }
    
    //MARK: - Stat
    private func getStat(doc: Document) throws -> Stat {
        guard let basicAbility = try? getBasicAbility(doc: doc) else {
            throw CrawlError.searchError //뭐 나중에는 어떤 에러인지 상세하게
        }
        
        guard let propensities = try? getPropensities(doc: doc) else {
            throw CrawlError.searchError //뭐 나중에는 어떤 에러인지 상세하게
        }
        
        guard let engravigs = try? getEngravigs(doc: doc) else {
            throw CrawlError.searchError //뭐 나중에는 어떤 에러인지 상세하게
        }
        
        return Stat(basicAbility: basicAbility, propensities: propensities, engravigs: engravigs)
    }
    
    private func getBasicAbility(doc: Document) throws -> BasicAbility {
        let attack = try doc.select("#profile-char > div:nth-child(1) > ul > li:nth-child(1) > span:nth-child(2)").text()
        let vitality = try doc.select("#profile-char > div:nth-child(1) > ul > li:nth-child(2) > span:nth-child(2)").text()
        let crit = try doc.select("#profile-char > div:nth-child(2) > ul > li:nth-child(1) > span:nth-child(2)").text()
        let specialization = try doc.select("#profile-char > div:nth-child(2) > ul > li:nth-child(2) > span:nth-child(2)").text()
        let domination = try doc.select("#profile-char > div:nth-child(2) > ul > li:nth-child(3) > span:nth-child(2)").text()
        let swiftness = try doc.select("#profile-char > div:nth-child(2) > ul > li:nth-child(4) > span:nth-child(2)").text()
        let endurance = try doc.select("#profile-char > div:nth-child(2) > ul > li:nth-child(5) > span:nth-child(2)").text()
        let expertise = try doc.select("#profile-char > div:nth-child(2) > ul > li:nth-child(6) > span:nth-child(2)").text()
        
        return BasicAbility(attack: attack, vitality: vitality, crit: crit, specialization: specialization, domination: domination, swiftness: swiftness, endurance: endurance, expertise: expertise)
    }
    
    private func getPropensities(doc: Document) throws -> Propensities {
        guard let propensitiesJS = try? doc.select("body > script:nth-child(11)").first()?.data() else {
            throw CrawlError.documentError
        }
        
        let propensities = (propensitiesJS.components(separatedBy: ";")[safe: 6] ?? "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "$(document).ready(function(){lui.profile.StatesGraph([{id:'#chart-states',value:[", with: "")
            .replacingOccurrences(of: "],//성향그래프수치max:1000}])", with: "")
            .replacingOccurrences(of: "isEmptyText()", with: "")
            .components(separatedBy: ",")
        
        return Propensities(intellect: propensities[safe: 0] ?? "-",
                            courage: propensities[safe: 1] ?? "-",
                            charm: propensities[safe: 2] ?? "-",
                            kindness: propensities[safe: 3] ?? "-")
    }
    
    private func getEngravigs(doc: Document) throws -> [Engraving] {
        let engravigElements = try doc.select("#profile-char > div.profile-ability-engrave > ul").first()?.children() ?? Elements()
        
        let engravigs: [Engraving] = engravigElements.compactMap {
            do {
                let name = try $0.select("span").text()
                let description = try $0.select("p").text()
                
                return Engraving(title: name, describtion: description)
            } catch {
                return nil
            }
        }
        
        return engravigs
    }
    
    //MARK: - JsonInfo
    private func getUserJsonInfo(doc: Document) throws -> UserJsonInfo {
        guard let wholeJsonString = try? doc.select("#profile-ability > script").first()?.data() else {
            throw CrawlError.jsonInfoError
        }
        
        let replacedString = wholeJsonString
            .replacingOccurrences(of: "$.Profile = ", with: "")
            .replacingOccurrences(of: ";", with: "")
        
        guard let jsonInfoManager = try? JsonInfoManager(jsonString: replacedString) else {
            throw CrawlError.jsonInfoError
        }
        
        //장비 관련
        let equips = jsonInfoManager.getEquipmentsInfo()
        
        //스킬 관련
        let usedSkillPoint = try? doc.select("#profile-skill-battle > div > div.profile-skill__point > em:nth-child(2)").text()
        let totalSkillPoint = try? doc.select("#profile-skill-battle > div > div.profile-skill__point > em:nth-child(4)").text()
        let skiils = jsonInfoManager.getSkills()
        
        let skillInfo = SkillInfo(usedSkillPoint: usedSkillPoint ?? "-",
                                  totalSkillPoint: totalSkillPoint ?? "-",
                                  skills: skiils)
        
        let cardInfo = jsonInfoManager.getCardInfo()

        return UserJsonInfo(equips: equips, skillInfo: skillInfo, cardInfo: cardInfo)
    }
    
    //MARK: - 점검 확인
    
    func chenckInspection() throws {
        guard let url = makeURL(urlString: baseURL, name: "") else {
            return
        }
        
        guard let doc = try? makeDocument(url: url) else {
            return
        }
        
        guard let a = try? doc.select("title").text(), a == "로스트아크 - 서비스 점검" else {
            return
        }
        
        throw CrawlError.inspection
    }
}
