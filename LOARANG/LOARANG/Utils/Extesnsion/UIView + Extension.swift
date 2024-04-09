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
