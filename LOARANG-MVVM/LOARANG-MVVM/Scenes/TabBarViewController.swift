//
//  TabBarViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private let container = Container(storage: MockStorage())

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarView()        
    }
    
    private func setTabBarView() {
        self.tabBar.tintColor = .buttonColor
        self.setViewControllers([mainVC, settingVC], animated: true)
    }
    
    private lazy var mainVC: UINavigationController = {
        let mainVC = UINavigationController(rootViewController: container.makeMainViewController())
        mainVC.title = "홈"
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        return mainVC
    }()
    
    private lazy var settingVC: UINavigationController = {
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        settingVC.title = "설정"
        settingVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        
        return settingVC
    }()

}
