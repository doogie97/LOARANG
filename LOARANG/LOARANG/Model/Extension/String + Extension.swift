//
//  String + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

extension String {
    func changeToPercent() -> String {
        let string = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let string = string else {
            return "error"
        }
        return string
    }
    var centerName: String {
        let removedAlign = self.replacingOccurrences(of: "<P ALIGN='CENTER'>", with: "")
        let removedFont = removedAlign.replacingOccurrences(of: "</FONT>", with: "")
        let removedP = removedFont.replacingOccurrences(of: "</P>", with: "")
        let center = removedP.components(separatedBy: ">")[1]
        
        return center
    }

}
