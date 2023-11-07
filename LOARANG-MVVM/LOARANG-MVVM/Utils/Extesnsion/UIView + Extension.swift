//
//  UIView + Extension.swift
//  LOARANG-MVVM
//
//  Created by Doogie on 11/8/23.
//

import UIKit
import GoogleMobileAds

extension UIView {
    var adMobView: GADBannerView {
        let bannerView = GADBannerView()
        bannerView.adUnitID = "ca-app-pub-4143146215451138/3114898326"
        
        return bannerView
    }
}
