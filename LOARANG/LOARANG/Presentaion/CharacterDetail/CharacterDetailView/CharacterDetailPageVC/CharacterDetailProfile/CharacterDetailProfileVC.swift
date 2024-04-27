//
//  CharacterDetailProfileVC.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit
import GoogleMobileAds

final class CharacterDetailProfileVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    var hasBanner: Bool?
    private lazy var sectionView = CharacterDetailProfileSectionView()
    
    private(set) lazy var bannerView: GADBannerView = {
        let bannerView = view.adMobView
        bannerView.layer.opacity = 0
        bannerView.delegate = self
        
        return bannerView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bannerView.load(GADRequest())
    }
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
        sectionView.setViewContents(viewModel: viewModel)
    }
    
    private func setLayout() {
        self.view.backgroundColor = .cellBackgroundColor
        self.view.addSubview(sectionView)
        self.view.addSubview(bannerView)
        
        sectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.view.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            $0.top.equalTo(sectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}

extension CharacterDetailProfileVC: GADBannerViewDelegate {
    func showAdView(_ isShow: Bool) {
        if self.hasBanner == isShow {
            return
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let bannerView = self?.bannerView,
                  let sectionView = self?.sectionView,
                  let safeAreaLayoutGuide = self?.view.safeAreaLayoutGuide else {
                return
            }
            if isShow {
                sectionView.snp.remakeConstraints {
                    $0.top.leading.trailing.equalToSuperview()
                    $0.bottom.equalTo(bannerView.snp.top)
                }
                
                bannerView.snp.remakeConstraints {
                    $0.bottom.equalTo(safeAreaLayoutGuide)
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(60)
                }
                bannerView.layer.opacity = 1
            } else {
                sectionView.snp.remakeConstraints {
                    $0.edges.equalToSuperview()
                }
                
                bannerView.snp.remakeConstraints {
                    $0.top.equalTo(sectionView.snp.bottom)
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(60)
                }
                bannerView.layer.opacity = 0
            }
            
            self?.view.layoutIfNeeded()
        }
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        showAdView(true)
        self.hasBanner = true
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        showAdView(false)
        self.hasBanner = false
    }
}
