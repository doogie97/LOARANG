//
//  UIImage + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

extension UIImage {
    enum CropCase {
        case circle
        case topSqure
    }
    func cropImage(characterClass: CharacterClass, cropCase: CropCase = .circle) -> UIImage? {
        var cropZone = CGRect()
        switch cropCase {
        case .circle:
            if characterClass == .aeromancer || characterClass == .artist || characterClass.rawValue == "스페셜리스트" {
                cropZone = CGRect(x: 215, y: 180, width: 180, height: 180)
            } else {
                cropZone = CGRect(x: 210, y: 60, width: 200, height: 200)
            }
        case .topSqure:
            if characterClass == .aeromancer || characterClass == .artist || characterClass.rawValue == "스페셜리스트" {
                cropZone = CGRect(x: -20, y: 180, width: 600, height: 350)
            } else {
                cropZone = CGRect(x: -0, y: 60, width: 500, height: 300)
            }
        }
        
        guard let cutImageRef = self.cgImage?.cropping(to: cropZone) else {
            return nil
        }
        
        return UIImage(cgImage: cutImageRef)
    }
}
