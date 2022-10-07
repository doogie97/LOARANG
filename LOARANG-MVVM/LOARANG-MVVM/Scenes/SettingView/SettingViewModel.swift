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
    var showAlert: PublishRelay<String?> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
    var showWebView: PublishRelay<(url: URL, title: String)> { get }
}

final class SettingViewModel: SettingViewModelable {
    private let storage: AppStorageable
    
    init(storage: AppStorageable) {
        self.storage = storage
    }
    //input
    func touchSearchButton(_ userName: String) {
        startedLoading.accept(())
        CrawlManager().getUserInfo(userName) { [weak self] result in
            switch result {
            case .success(let userInfo):
                self?.checkUser.accept(MainUser(image: userInfo.mainInfo.userImage,
                                          battleLV: userInfo.mainInfo.battleLV,
                                          name: userInfo.mainInfo.name,
                                          class: userInfo.mainInfo.`class`,
                                          itemLV: userInfo.mainInfo.itemLV,
                                          server: userInfo.mainInfo.server))
            case .failure(_):
                self?.showAlert.accept("검색하신 유저가 없습니다")
            }
            self?.finishedLoading.accept(())
        }
    }
    
    func changeMainUser(_ mainUser: MainUser) {
        do {
            try storage.changeMainUser(mainUser)
            showAlert.accept("대표 캐릭터 설정이 완료되었습니다")
        } catch {
            showAlert.accept(error.errorMessage)
        }
    }
    
    //output
    let checkUser = PublishRelay<MainUser>()
    let showAlert = PublishRelay<String?>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
    var showWebView = PublishRelay<(url: URL, title: String)>()
}
