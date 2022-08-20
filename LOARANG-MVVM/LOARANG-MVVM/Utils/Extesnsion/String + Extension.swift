//
//  String + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
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
    
    func htmlToAttributedString(alignment: HtmlAlignment = .CENTER) -> NSAttributedString? {
        let newHTML = self.replacingOccurrences(of: "CENTER", with: alignment.rawValue)
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
    
    var htmlToString: String { // 추후 사용 안하면 제거 
        return htmlToAttributedString()?.string ?? ""
    }
}
