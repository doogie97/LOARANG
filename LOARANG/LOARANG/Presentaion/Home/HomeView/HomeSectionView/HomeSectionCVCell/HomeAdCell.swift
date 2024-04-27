//
//  HomeAdCell.swift
//  LOARANG
//
//  Created by Doogie on 4/27/24.
//

import UIKit
import SnapKit
import GoogleMobileAds

final class HomeAdCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var bannerView: GADBannerView = {
        let bannerView = adMobView
        bannerView.delegate = self
        
        return bannerView
    }()
    
    func setCellContents() {
        bannerView.load(GADRequest())
    }
}

extension HomeAdCell: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("성공")
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("실패")
    }
}
