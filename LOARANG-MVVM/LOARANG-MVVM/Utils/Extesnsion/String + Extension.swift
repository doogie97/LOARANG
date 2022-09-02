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
}
