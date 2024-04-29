//
//  CharacterDetailPageVCDelegate.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import GoogleMobileAds

protocol PageViewInnerVCDelegate {
    var hasBanner: Bool? { get }
    var bannerView: GADBannerView { get }
    
    func setViewContents(viewModel: CharacterDetailVMable?)
    func showAdView(_ isShow: Bool)
}
