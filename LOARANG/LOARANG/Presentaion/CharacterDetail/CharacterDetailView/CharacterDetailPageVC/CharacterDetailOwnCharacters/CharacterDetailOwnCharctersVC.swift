//
//  CharacterDetailOwnCharctersVC.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit
import GoogleMobileAds

final class CharacterDetailOwnCharctersVC: UIViewController, PageViewInnerVCDelegate {
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
    
    private lazy var ownCharactersTV = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .mainBackground
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(CharacterDetailOwnCharacterCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
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
    }
    
    private func setLayout() {
        self.view.addSubview(ownCharactersTV)
        self.view.addSubview(bannerView)
        ownCharactersTV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerView.snp.makeConstraints {
            $0.top.equalTo(ownCharactersTV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}

extension CharacterDetailOwnCharctersVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.ownCharactersInfoData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.ownCharactersInfoData[safe: section]?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharacterDetailOwnCharacterCell.self)", for: indexPath) as? CharacterDetailOwnCharacterCell,
              let ownCharactersInfo = viewModel?.ownCharactersInfoData,
              let severInfo = ownCharactersInfo[safe: indexPath.section],
              let character = severInfo.characters[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellContents(character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let severInfo = viewModel?.ownCharactersInfoData[safe: section] else {
            return nil
        }
        
        let headerView = UIView()
        let severName = severInfo.gameServer.rawValue
        let characterCount = severInfo.characters.count
        let serverLabel = view.pretendardLabel(size: 14, family: .Regular, color: .systemGray, text: "\(severName)(\(characterCount))")
        headerView.addSubview(serverLabel)
        serverLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(view.margin(.width, 16))
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.touchOwnCharacterCell(indexPath)
    }
}

extension CharacterDetailOwnCharctersVC: GADBannerViewDelegate {
    func showAdView(_ isShow: Bool) {
        if self.hasBanner == isShow {
            return
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let bannerView = self?.bannerView,
                  let ownCharactersTV = self?.ownCharactersTV,
                  let safeAreaLayoutGuide = self?.view.safeAreaLayoutGuide else {
                return
            }
            if isShow {
                ownCharactersTV.snp.remakeConstraints {
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
                ownCharactersTV.snp.remakeConstraints {
                    $0.edges.equalToSuperview()
                }
                
                bannerView.snp.remakeConstraints {
                    $0.top.equalTo(ownCharactersTV.snp.bottom)
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
