//
//  SceneDelegate.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let config = Realm.Configuration(schemaVersion: 0)
        Realm.Configuration.defaultConfiguration = config
        
        guard let realm = try? Realm() else {
            window?.rootViewController = UIViewController()
            window?.rootViewController?.showExitAlert(message: "앱 저장소 오류가 발생했습니다.\n앱 재설치 혹은 고객센터로 문의 부탁드립니다.")
            return
        }
        
        let container = Container(storage: AppStorage(LocalStorage(realm: realm)))
        let navigationController = UINavigationController(rootViewController: TabBarViewController(container))
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
    }
}

