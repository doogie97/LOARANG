//
//  UIImage + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

extension UIImage {
    //class CharacterClass 받도록 수정 필요
    func cropImage(characterClass: CharacterClass) -> UIImage? {
        var cropZone = CGRect()
        
        if characterClass == .aeromancer || characterClass == .artist || characterClass.rawValue == "스페셜리스트" {
            cropZone = CGRect(x: 215, y: 180, width: 180, height: 180)
        } else {
            cropZone = CGRect(x: 210, y: 60, width: 200, height: 200)
        }
        
        guard let cutImageRef = self.cgImage?.cropping(to: cropZone) else {
            return nil
        }
        
        return UIImage(cgImage: cutImageRef)
    }
}
