//
//  SettingView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/04.
//

import SnapKit
import GoogleMobileAds

final class SettingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        
        label.font = UIFont.one(size: 30, family: .Bold)
        
        return label
    }()
    
    private(set) lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .tableViewColor
        tableView.separatorStyle = .none
        
        tableView.register(SettingTVCell.self)
        
        return tableView
    }()
    
    private(set) lazy var bannerView: GADBannerView = {
        let bannerView = adMobView
        bannerView.delegate = self        
        
        return bannerView
    }()
    
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        indicator.stopAnimating()
        
        return indicator
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.addSubview(titleLabel)
        self.addSubview(menuTableView)
        self.addSubview(bannerView)
        self.addSubview(activityIndicator)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        menuTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(bannerView.snp.top)
        }
        
        bannerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension SettingView: GADBannerViewDelegate {
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print(error)
    }
}
