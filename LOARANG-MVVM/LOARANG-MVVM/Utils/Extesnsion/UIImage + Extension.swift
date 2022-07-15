//
//  UIImage + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

extension UIImage {
    func cropImage(class: String) -> UIImage? {
        var cropZone = CGRect()
        
        if `class` == "기상술사" || `class` == "도화가" || `class` == "스페셜리스트" {
            cropZone = CGRect(x: 220, y: 180, width: 180, height: 180)
        } else {
            cropZone = CGRect(x: 220, y: 80, width: 180, height: 180)
        }
        
        guard let cutImageRef = self.cgImage?.cropping(to: cropZone) else {
            return nil
        }
        
        return UIImage(cgImage: cutImageRef)
    }
}
