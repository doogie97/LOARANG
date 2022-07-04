//
//  String + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//
import Foundation

extension String {
    func changeToPercent() -> String {
        let string = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let string = string else {
            return "error"
        }
        return string
    }
    
    func crawlUser(_ completion: @escaping (Result<UserInfo, Error>) -> Void) {
        DispatchQueue.global().async {
            do {
                let info = try CrawlManager.shared.searchUser(userName: self)
                DispatchQueue.main.async {
                    completion(.success(info))
                }
            } catch(let error) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    var centerNameOne: String {
        let stringArray = self
            .replacingOccurrences(of: "<P ALIGN='CENTER'>", with: "")
            .replacingOccurrences(of: "</FONT>", with: "")
            .replacingOccurrences(of: "</P>", with: "")
            .components(separatedBy: ">")
        
        if stringArray.count < 2 {
            return stringArray.joined()
        }
        
        return stringArray[1]
    }

    var centerNameTwo: String {
        return self.components(separatedBy: ">")[2].components(separatedBy: "<")[0]
    }
    
    var tripod: String {
        if self.isEmpty {
            return ""
        }
        let stringArray = self.components(separatedBy: "]")
        let skilname = stringArray[1].centerNameOne
        let tripodName = stringArray[2].components(separatedBy: "<")[0]
        let tripodLV = stringArray[2].centerNameOne
        
        return "[\(skilname)]\(tripodName)\(tripodLV)"
    }
    
    var setLv: String {
        if self.isEmpty {
            return ""
        }
        let setName = self.components(separatedBy: "<")[0]
        let lv = self.centerNameOne
        
        return setName + lv
    }
    
    var estherEffect: String {
        return self
            .replacingOccurrences(of: "<FONT COLOR='#33ffcc'>", with: "")
            .replacingOccurrences(of: "</FONT>", with: "")
            .replacingOccurrences(of: "<BR>", with: "\n")
            .replacingOccurrences(of: "<FONT COLOR='#ffff99'>", with: "")
            .replacingOccurrences(of: "<FONT COLOR='#99ff99'>", with: "")
    }
}
