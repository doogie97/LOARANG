//
//  UIImage + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

extension UIImage {
    func cropImage() -> UIImage? {
        let cropZone = CGRect(x: 220, y: 80, width: 180, height: 180)
        
        guard let cutImageRef = self.cgImage?.cropping(to: cropZone) else {
            return nil
        }
        
        return UIImage(cgImage: cutImageRef)
    }
}
