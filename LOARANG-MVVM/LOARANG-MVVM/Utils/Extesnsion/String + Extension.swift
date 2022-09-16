//
//  String + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import UIKit

extension String {
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
    
    var classImage: UIImage? {
        switch self {
        case "디스트로이어":
            return UIImage(named: "emblem_destroyer")
        case "워로드":
            return UIImage(named: "emblem_warlord")
        case "버서커":
            return UIImage(named: "emblem_berserker")
        case "홀리나이트":
            return UIImage(named: "emblem_holyknight")
        case "스트라이커":
            return UIImage(named: "emblem_battle_master_male")
        case "배틀마스터":
            return UIImage(named: "emblem_battle_master")
        case "인파이터":
            return UIImage(named: "emblem_infighter")
        case "기공사":
            return UIImage(named: "emblem_force_master")
        case "창술사":
            return UIImage(named: "emblem_lance_master")
        case "데빌헌터":
            return UIImage(named: "emblem_devil_hunter")
        case "블래스터":
            return UIImage(named: "emblem_blaster")
        case "호크아이":
            return UIImage(named: "emblem_hawk_eye")
        case "스카우터":
            return UIImage(named: "emblem_scouter")
        case "건슬링어":
            return UIImage(named: "emblem_devil_hunter_female")
        case "바드":
            return UIImage(named: "emblem_bard")
        case "서머너":
            return UIImage(named: "emblem_summoner")
        case "아르카나":
            return UIImage(named: "emblem_arcana")
        case "소서리스":
            return UIImage(named: "emblem_elemental_master")
        case "블레이드":
            return UIImage(named: "emblem_blade")
        case "데모닉":
            return UIImage(named: "emblem_demonic")
        case "리퍼":
            return UIImage(named: "emblem_reaper")
        case "도화가":
            return UIImage(named: "emblem_yinyangshi")
        case "기상술사":
            return UIImage(named: "emblem_weather_artist")
        default:
            return nil
        }
    }
}
