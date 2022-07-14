//
//  TabBarViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private let mainVC = UINavigationController(rootViewController: MainViewController())
    private let settingVC = UINavigationController(rootViewController: SettingViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarView()        
    }
    
    private func setTabBarView() {
        setMainVCButton()
        settingVCButton()
        self.tabBar.tintColor = .backButtonColor
        self.setViewControllers([mainVC, settingVC], animated: true)
    }
    
    private func setMainVCButton() {
        mainVC.title = "홈"
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
    }
    
    private func settingVCButton() {
        settingVC.title = "설정"
        settingVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
    }
}
