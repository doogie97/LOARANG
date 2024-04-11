//
//  UIView + Extension.swift
//  LOARANG-MVVM
//
//  Created by Doogie on 11/8/23.
//

import UIKit
import GoogleMobileAds

extension UIView {
    enum Direction {
        case height
        case width
    }
    
    func margin(_ direction: Direction, _ margine: Double) -> Double {
        let defaultHeight: Double = 852
        let deaultWidth: Double = 393
        
        switch direction {
        case .height:
            return round(UIScreen.main.bounds.height * margine/defaultHeight)
        case .width:
            return round(UIScreen.main.bounds.width * margine/deaultWidth)
        }
    }
    
    var isSE: Bool {
        return UIScreen.main.bounds.height <= 667
    }
    
    func oneFontLabel(size: Int = 14, family: UIFont.Family = .Bold, color: UIColor = .white, text: String = "") -> UILabel {
        let label = UILabel()
        label.font = UIFont.one(size: size, family: family)
        label.textColor = color
        label.text = text
        
        return label
    }
    
    func blackHanSansLabel(size: Int = 20, color: UIColor = .white, text: String = "") -> UILabel {
        let label = UILabel()
        label.font = UIFont.BlackHanSans(size: size)
        label.textColor = color
        label.text = text
        
        return label
    }
    
    var adMobView: GADBannerView {
        let bannerView = GADBannerView()
#if DEBUG
        //TEST KEY
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
#else
        //REAL KEY
        bannerView.adUnitID = "ca-app-pub-4143146215451138/3114898326"
#endif
        return bannerView
    }
}
