//
//  SettingViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/10.
//

import RxRelay

protocol SettingViewModelable: SettingViewModeInput, SettingViewModeOutput {}

protocol SettingViewModeInput {
    func touchSearchButton(_ userName: String)
    func changeMainUser(_ mainUser: MainUser)
}

protocol SettingViewModeOutput {
    var checkUser: PublishRelay<MainUser> { get }
    var showErrorAlert: PublishRelay<String> { get }
}

final class SettingViewModel: SettingViewModelable {
    private let storage: AppStorageable
    private let crawlManager: CrawlManagerable
    
    init(storage: AppStorageable, crawlManger: CrawlManagerable) {
        self.storage = storage
        self.crawlManager = crawlManger
    }
    //input
    func touchSearchButton(_ userName: String) {
        crawlManager.getUserInfo(userName) { [weak self] result in
            switch result {
            case .success(let userInfo):
                self?.checkUser.accept(MainUser(image: userInfo.basicInfo.userImage,
                                          battleLV: userInfo.basicInfo.battleLV,
                                          name: userInfo.basicInfo.name,
                                          class: userInfo.basicInfo.`class`,
                                          itemLV: userInfo.basicInfo.itemLV,
                                          server: userInfo.basicInfo.server))
            case .failure(_):
                self?.showErrorAlert.accept("검색하신 유저가 없습니다")
            }
        }
    }
    
    func changeMainUser(_ mainUser: MainUser) {
        storage.changeMainUser(mainUser)
    }
    
    //output
    let checkUser = PublishRelay<MainUser>()
    let showErrorAlert = PublishRelay<String>()
}
