//
//  String + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

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
}
