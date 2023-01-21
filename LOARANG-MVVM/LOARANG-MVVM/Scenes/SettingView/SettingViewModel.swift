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
    func touchNoticeCell()
    func touchSuggestioinCell()
}

protocol SettingViewModeOutput {
    var checkUser: PublishRelay<MainUser> { get }
    var showAlert: PublishRelay<String?> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
    var showWebView: PublishRelay<(url: URL, title: String)> { get }
    var showSafari: PublishRelay<URL> { get }
}

final class SettingViewModel: SettingViewModelable {
    private let storage: AppStorageable
    
    init(storage: AppStorageable) {
        self.storage = storage
    }
    //input
    func touchSearchButton(_ userName: String) {
        startedLoading.accept(())
        Task {
            do {
                let searchResult = try await CrawlManager().getUserInfo2(userName)
                await MainActor.run {
                    checkUser.accept(MainUser(image: searchResult.mainInfo.userImage,
                                              battleLV: searchResult.mainInfo.battleLV,
                                              name: searchResult.mainInfo.name,
                                              class: searchResult.mainInfo.class,
                                              itemLV: searchResult.mainInfo.itemLV,
                                              server: searchResult.mainInfo.server))
                    finishedLoading.accept(())
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept(error.errorMessage)
                    finishedLoading.accept(())
                }
            }
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
    
    func touchNoticeCell() {
        guard let url = URL(string: "https://velog.io/@doogie97/%EB%A1%9C%EC%95%84%EB%9E%91LOARANG-%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD") else {
            return
        }
        
        showWebView.accept((url: url, title: "로아랑 공지사항"))
    }
    
    func touchSuggestioinCell() {
        guard let url = URL(string: "https://open.kakao.com/o/s5vNiUGe"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        showSafari.accept(url)
    }
    
    //output
    let checkUser = PublishRelay<MainUser>()
    let showAlert = PublishRelay<String?>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
    let showWebView = PublishRelay<(url: URL, title: String)>()
    let showSafari = PublishRelay<URL>()
}
