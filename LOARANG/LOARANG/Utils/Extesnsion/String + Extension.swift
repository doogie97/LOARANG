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
    
    var convetDateType: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        dateFormatter.dateFormat = "MM.dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func numberOfLines(labelWidth: CGFloat, font: UIFont) -> Int {
        let textSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = (self as NSString).boundingRect(with: textSize,
                                                            options: .usesLineFragmentOrigin,
                                                            attributes: [NSAttributedString.Key.font: font],
                                                            context: nil)
        let numberOfLines = Int(ceil(boundingRect.height / font.lineHeight))
        return numberOfLines
    }
}
