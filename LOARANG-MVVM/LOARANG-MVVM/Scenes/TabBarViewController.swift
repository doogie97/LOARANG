//
//  TabBarViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private let container: Container
    
    init(_ container: Container) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarView()
    }
    
    private func setTabBarView() {
        self.tabBar.tintColor = .buttonColor
        self.tabBar.backgroundColor = .systemGray5
        self.setViewControllers([mainVC, marketVC, auctionVC, settingVC], animated: false)
    }
    
    private lazy var mainVC: UIViewController = {
        let mainVC = container.makeMainViewController()
        mainVC.title = "홈"
        mainVC.tabBarItem.image = UIImage(named: "home")
        
        return mainVC
    }()
    
    private lazy var marketVC: UIViewController = {
        let marketVC = container.makeMarketViewController()
        marketVC.title = "거래소"
        marketVC.tabBarItem.image = UIImage(named: "cart")
        
        return marketVC
    }()
    
    private lazy var auctionVC: UIViewController = {
        let marketVC = container.makeAuctionViewController()
        marketVC.title = "경매장"
        marketVC.tabBarItem.image = UIImage(named: "auction")
        
        return marketVC
    }()
    
    private lazy var settingVC: UIViewController = {
        let settingVC = SettingViewController(viewModel: container.makeSettingViewModel(), container: container)
        settingVC.title = "설정"
        settingVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        
        return settingVC
    }()
}
