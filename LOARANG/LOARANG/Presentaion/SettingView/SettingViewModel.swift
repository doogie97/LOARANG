//
//  SettingViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/10.
//

import UIKit
import RxRelay

protocol SettingViewModelable: SettingViewModeInput, SettingViewModeOutput {}

protocol SettingViewModeInput {
    func touchSearchButton(_ userName: String)
    func touchDeleteMainUserCell()
    func deleteMainUser()
    func changeMainUser(_ mainUser: MainUserEntity)
    func touchNoticeCell()
    func touchSuggestioinCell()
}

protocol SettingViewModeOutput {
    var showAlert: PublishRelay<SettingViewModel.AlertCase> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
    var showWebView: PublishRelay<(url: URL, title: String)> { get }
    var showSafari: PublishRelay<URL> { get }
}

final class SettingViewModel: SettingViewModelable {
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    private let changeMainUserUseCase: ChangeMainUserUseCase
    private let deleteMainUserUseCase: DeleteMainUserUseCase
    init(getCharacterDetailUseCase: GetCharacterDetailUseCase,
         changeMainUserUseCase: ChangeMainUserUseCase,
         deleteMainUserUseCase: DeleteMainUserUseCase) {
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.changeMainUserUseCase = changeMainUserUseCase
        self.deleteMainUserUseCase = deleteMainUserUseCase
    }
    //input
    func touchSearchButton(_ userName: String) {
        startedLoading.accept(())
        Task {
            do {
                let searchResult = try await getCharacterDetailUseCase.excute(name: userName)
                await MainActor.run {
                    showAlert.accept(.checkUser(userInfo: MainUserEntity(imageUrl: searchResult.profile.imageUrl,
                                                                         battleLV: searchResult.profile.battleLevel,
                                                                         name: searchResult.profile.characterName,
                                                                         characterClass: searchResult.profile.characterClass,
                                                                         itemLV: searchResult.profile.itemLevel,
                                                                         expeditionLV: searchResult.profile.expeditionLevel,
                                                                         gameServer: searchResult.profile.gameServer)))
                    finishedLoading.accept(())
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept(.basic(message: error.errorMessage))
                    finishedLoading.accept(())
                }
            }
        }
    }
    
    func changeMainUser(_ mainUser: MainUserEntity) {
        do {
            try changeMainUserUseCase.execute(user: mainUser)
            showAlert.accept(.basic(message: "대표 캐릭터 설정이 완료되었습니다!"))
        } catch {
            showAlert.accept(.basic(message: error.errorMessage))
        }
    }
    
    func touchDeleteMainUserCell() {
        showAlert.accept(.deleteMainUser)
    }
    
    func deleteMainUser() {
        do {
            try deleteMainUserUseCase.execute()
            showAlert.accept(.basic(message: "대표 캐릭터 삭제가 완료되었습니다."))
        } catch let error {
            showAlert.accept(.basic(message: error.errorMessage))
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
    
    //MARK: - Output
    enum AlertCase {
        case basic(message: String)
        case checkUser(userInfo: MainUserEntity)
        case deleteMainUser
    }
    
    let showAlert = PublishRelay<AlertCase>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
    let showWebView = PublishRelay<(url: URL, title: String)>()
    let showSafari = PublishRelay<URL>()
}
