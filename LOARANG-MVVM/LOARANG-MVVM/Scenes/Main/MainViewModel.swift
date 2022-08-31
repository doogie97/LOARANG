//
//  MainViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

protocol MainViewModelInOut: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {
    func touchSerachButton()
    func touchMainUser()
    func touchBookMarkCell(_ index: Int)
}
protocol MainViewModelOutput {
    var mainUser: BehaviorRelay<MainUser?> { get }
    var bookmarkUser: BehaviorRelay<[BookmarkUser]> { get }
    var showSearchView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<UserInfo> { get }
    var showAlert: PublishRelay<String?> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
}

final class MainViewModel: MainViewModelInOut {
    private var storage: AppStorageable
    private var crawlManager: CrawlManagerable
    
    init(storage: AppStorageable, crawlManager: CrawlManagerable) {
        self.storage = storage
        self.crawlManager = crawlManager
        self.mainUser = storage.mainUser
        self.bookmarkUser = storage.bookMark
    }
    
    // in
    func touchSerachButton() {
        showSearchView.accept(())
    }
    
    func touchMainUser() {
        guard let mainUser = mainUser.value else {
            return
        }
        
        startedLoading.accept(())
        crawlManager.getUserInfo(mainUser.name) { [weak self] result in
            self?.finishedLoading.accept(())
            
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
                
                do {
                    try self?.storage.changeMainUser(MainUser(image: userInfo.mainInfo.userImage,
                                                              battleLV: userInfo.mainInfo.battleLV,
                                                              name: userInfo.mainInfo.name,
                                                              class: userInfo.mainInfo.`class`,
                                                              itemLV: userInfo.mainInfo.itemLV,
                                                              server: userInfo.mainInfo.server))
                } catch {
                    guard let error = error as? LocalStorageError else {
                        self?.showAlert.accept(nil)
                        return
                    }
                    
                    self?.showAlert.accept(error.errorDescrption)
                }
            case .failure(_):
                self?.showAlert.accept(nil)
                return
            }
        }
    }
    
    func touchBookMarkCell(_ index: Int) {
        startedLoading.accept(())
        guard let userName = storage.bookMark.value[safe: index]?.name else {
            return
        }
        
        crawlManager.getUserInfo(userName) { [weak self] result in
            self?.finishedLoading.accept(())
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
                
                do {
                    try self?.storage.updateUser(BookmarkUser(name: userName,
                                                              image: userInfo.mainInfo.userImage,
                                                              class: userInfo.mainInfo.`class`))
                } catch {
                    guard let error = error as? LocalStorageError else {
                        self?.showAlert.accept(nil)
                        return
                    }
                    
                    self?.showAlert.accept(error.errorDescrption)
                }
            case .failure(_):
                self?.showAlert.accept(nil)
                return
            }
        }
    }
    
    // out
    let mainUser: BehaviorRelay<MainUser?>
    let bookmarkUser: BehaviorRelay<[BookmarkUser]>
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<UserInfo>()
    let showAlert = PublishRelay<String?>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
}
