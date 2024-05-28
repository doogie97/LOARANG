//
//  SceneDelegate.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        setRealmConfig()
        
        guard let realm = try? Realm() else {
            window?.rootViewController = UIViewController()
            window?.rootViewController?.showExitAlert(message: "앱 저장소 오류가 발생했습니다.\n앱 재설치 혹은 고객센터로 문의 부탁드립니다.")
            return
        }
        let localStorageRepository = LocalStorageRepository(realm: realm)
        let container = Container(localStorageRepository: localStorageRepository)
        let navigationController = UINavigationController(rootViewController: TabBarViewController(container))
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
    }
    
    private func setRealmConfig() {
        let config = Realm.Configuration(
            schemaVersion: 2) { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: MainUserDTO.className()) { oldObject, newObject in
                        newObject?["imageUrl"] = ""
                        newObject?["expeditionLV"] = 0
                        newObject?["characterClass"] = oldObject?["class"]
                        
                        let oldBattleLV = (oldObject?["battleLV"] as? String) ?? ""
                        newObject?["battleLV"] = Int(oldBattleLV) ?? 0
                        
                        let oldSever = (oldObject?["server"] as? String) ?? ""
                        newObject?["gameServer"] = oldSever.replacingOccurrences(of: "@", with: "")
                    }
                    
                    migration.enumerateObjects(ofType: BookmarkUserDTO.className()) { oldObject, newObject in
                        newObject?["imageUrl"] = ""
                        newObject?["characterClass"] = oldObject?["class"]
                    }
                    
                    migration.enumerateObjects(ofType: RecentUserDTO.className()) { oldObject, newObject in
                        newObject?["imageUrl"] = ""
                        newObject?["characterClass"] = oldObject?["class"]
                    }
                }
                
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: RecentUserDTO.className()) { _, newObject in
                        if let recentUserData = try? Realm().objects(BookmarkUserDTO.self),
                           let name = (newObject?["name"] as? String),
                           Array(recentUserData).contains(where: { $0.name == name}) {
                            newObject?["isBookmark"] = true
                        } else {
                            newObject?["isBookmark"] = false
                        }
                    }
                }
            }
        Realm.Configuration.defaultConfiguration = config
    }
}

