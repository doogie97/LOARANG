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
        // 뷰 구성 전 검은 화면에서 어플을 종료하면 사용자에게 좋지않은 경험이 될 수 있어 뷰 구성 후 점검 확인 후 어플 종료하도록 유도
        // 추후 런치 스크린 추가시 런치스크린 화면에서 어플 종료 할 수 있도록 수정 필요
        Task {
            do {
                try await CrawlManager().checkInspection2()
            } catch {
                await MainActor.run {
                    showExitAlert(title:"서버 점검 중" ,message: "자세한 사항은 로스트아크 공식 홈페이지를 확인해 주세요")
                }
            }
        }
    }
    
    private func setTabBarView() {
        self.tabBar.tintColor = .buttonColor
        self.setViewControllers([mainVC, settingVC], animated: false)
    }
    
    private lazy var mainVC: UIViewController = {
        let mainVC = container.makeMainViewController()
        mainVC.title = "홈"
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        return mainVC
    }()
    
    private lazy var settingVC: UIViewController = {
        let settingVC = SettingViewController(viewModel: container.makeSettingViewModel(), container: container)
        settingVC.title = "설정"
        settingVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        
        return settingVC
    }()

}
