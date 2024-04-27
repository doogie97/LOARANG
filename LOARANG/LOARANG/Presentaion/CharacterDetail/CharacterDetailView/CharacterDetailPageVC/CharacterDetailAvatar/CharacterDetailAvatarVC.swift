//
//  CharacterDetailAvatarVC.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit
import GoogleMobileAds

final class CharacterDetailAvatarVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    var hasBanner: Bool?
    
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
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentsView = UIView()
    private lazy var characterImageView = UIImageView()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular), forImageIn: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(touchShareButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchShareButton() {
        guard let image = characterImageView.image else {
            return
        }
        viewModel?.touchShareImageButton(image)
    }
    
    private lazy var avatarListTV = {
        let tableView = DynamicHeightTableView()
        tableView.separatorStyle = .none
        tableView.register(CharatcerDetailAvatarCell.self)
        tableView.dataSource = self
        
        return tableView
    }()
    
    private(set) lazy var bannerView: GADBannerView = {
        let bannerView = view.adMobView
        bannerView.layer.opacity = 0
        bannerView.delegate = self
        
        return bannerView
    }()
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
        characterImageView.setImage(viewModel?.characterInfoData?.profile.imageUrl)
    }
    
    private func setLayout() {
        self.view.backgroundColor = #colorLiteral(red: 0.07950355858, green: 0.09458512813, blue: 0.1114221141, alpha: 1)
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentsView)
        contentsView.addSubview(characterImageView)
        contentsView.addSubview(shareButton)
        contentsView.addSubview(avatarListTV)
        self.view.addSubview(bannerView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 1.16)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.trailing.equalTo(characterImageView).inset(view.margin(.width, 16))
        }
        
        avatarListTV.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bannerView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}

extension CharacterDetailAvatarVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characterInfoData?.avatars.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharatcerDetailAvatarCell.self)", for: indexPath) as? CharatcerDetailAvatarCell,
              let avatar = viewModel?.characterInfoData?.avatars[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setCellContents(avatar: avatar)
        return cell
    }
}

extension CharacterDetailAvatarVC: GADBannerViewDelegate {
    func showAdView(_ isShow: Bool) {
        if self.hasBanner == isShow {
            return
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let bannerView = self?.bannerView,
                  let scrollView = self?.scrollView,
                  let safeAreaLayoutGuide = self?.view.safeAreaLayoutGuide else {
                return
            }
            if isShow {
                scrollView.snp.remakeConstraints {
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
                scrollView.snp.remakeConstraints {
                    $0.edges.equalToSuperview()
                }
                
                bannerView.snp.remakeConstraints {
                    $0.top.equalTo(scrollView.snp.bottom)
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
