//
//  String + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import UIKit

extension String {
    var toDouble: Double? {
        return Double(self.replacingOccurrences(of: ",", with: ""))
    }
    
    func changeToPercent() -> String {
        let string = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let string = string else {
            return "error"
        }
        return string
    }
    
    func threeNum(_ isFullLv: Bool) -> String {
        if isFullLv {
            return self
        } else {
            guard let num = Int(self) else {
                return ""
            }
            return String(format: "%03d", num + 1)
        }
    }
    
    enum HtmlAlignment: String {
        case LEFT
        case CENTER
        case RIGHT
    }
    
    func htmlToAttributedString(fontSize: Int = 10, alignment: HtmlAlignment = .CENTER) -> NSAttributedString? {
        
        let newHTML = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(fontSize + 12); color: #FFFFFF; \">%@</span>", self)
            .replacingOccurrences(of: "CENTER", with: alignment.rawValue)
            .replacingOccurrences(of: "font size=\'12", with: "font size=\'\(fontSize)")
            .replacingOccurrences(of: "font size=\'14", with: "font size=\'\(fontSize)")
            .replacingOccurrences(of: "FONT SIZE='14", with: "FONT SIZE='\(fontSize)")
            .replacingOccurrences(of: "FONT SIZE='11", with: "FONT SIZE='\(fontSize)")
            .replacingOccurrences(of: "FONT SIZE='12", with: "FONT SIZE='\(fontSize)")
        
        
        guard let data = newHTML.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString()?.string ?? ""
    }
    
    func stringWithSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        return attrString
    }
    
    var classImageURL: String? {
        let baseURL = "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/emblem_"
        switch self {
            
            //전직 후
        case "디스트로이어":
            return baseURL + "destroyer.png"
        case "워로드":
            return baseURL + "warlord.png"
        case "버서커":
            return baseURL + "berserker.png"
        case "홀리나이트":
            return baseURL + "holyknight.png"
        case "스트라이커":
            return baseURL + "battle_master_male.png"
        case "브레이커":
            return baseURL + "infighter_male.png"
        case "배틀마스터":
            return baseURL + "battle_master.png"
        case "인파이터":
            return baseURL + "infighter.png"
        case "기공사":
            return baseURL + "force_master.png"
        case "창술사":
            return baseURL + "lance_master.png"
        case "데빌헌터":
            return baseURL + "devil_hunter.png"
        case "블래스터":
            return baseURL + "blaster.png"
        case "호크아이":
            return baseURL + "hawk_eye.png"
        case "스카우터":
            return baseURL + "scouter.png"
        case "건슬링어":
            return baseURL + "devil_hunter_female.png"
        case "바드":
            return baseURL + "bard.png"
        case "서머너":
            return baseURL + "summoner.png"
        case "아르카나":
            return baseURL + "arcana.png"
        case "소서리스":
            return baseURL + "elemental_master.png"
        case "블레이드":
            return baseURL + "blade.png"
        case "데모닉":
            return baseURL + "demonic.png"
        case "리퍼":
            return baseURL + "reaper.png"
        case "도화가":
            return baseURL + "yinyangshi.png"
        case "기상술사":
            return baseURL + "weather_artist.png"
        case "슬레이어":
            return baseURL + "berserker_female.png"
        case "소울이터":
            return baseURL + "soul_eater.png"
            //전직 전
        case "스페셜리스트":
            return baseURL + "specialist.png"
        case "마법사":
            return baseURL + "magician.png"
        case "전사(남)":
            return baseURL + "warrior.png"
        case "전사(여)":
            return baseURL + "warrior_female.png"
        case "헌터(남)":
            return baseURL + "hunter.png"
        case "헌터(여)":
            return baseURL + "hunter_female.png"
        case "암살자":
            return baseURL + "assassin.png"
        case "무도가(남)":
            return baseURL + "fighter_male.png"
        case "무도가(여)":
            return baseURL + "fighter.png"
        default:
            return nil
        }
    }
    
    var convetDateType: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        dateFormatter.dateFormat = "MM.dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
