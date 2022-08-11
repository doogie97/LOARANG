//
//  CrawManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import SwiftSoup

protocol CrawlManagerable {
    func getUserInfo(_ name: String, completion: @escaping (Result<UserInfo, Error>) -> Void)
}

struct CrawlManager: CrawlManagerable {
    private let baseURL = "https://m-lostark.game.onstove.com/Profile/Character/"
    
    func getUserInfo(_ name: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        let stat: Stat? = nil // 추후에 이런식으로 다른 정보들도 가져와 놓은 다음에 이미지 다운이 완료되면 UserInfo만들어서 completion으로 보내기
        DispatchQueue.global().async {
            getBasicInfo(name: name) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let basicInfo):
                        completion(.success(UserInfo(basicInfo: basicInfo,
                                                     stat: stat,
                                                     equips: nil)))
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
    private func getBasicInfo(name: String, completion: @escaping (Result<BasicInfo, Error>) -> Void) {
        guard let url = makeURL(urlString: baseURL, name: name) else {
            completion(.failure(CrawlError.urlError))
            return
        }
        
        guard let doc = try? makeDocument(url: url) else {
            completion(.failure(CrawlError.documentError))
            return
        }
        
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
                completion(.success(BasicInfo(server: server, name: name, battleLV: battleLV, itemLV: itemLV, expeditionLV: expeditionLV, title: title, guild: guild, pvp: pvp, wisdom: wisdom, class: `class`, userImage: image)))
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
}
