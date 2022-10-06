//
//  UserInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol UserInfoViewModelable: UserInfoViewModelInput, UserInfoViewModelOutput, UserInfoViewModelDelegate {}

protocol UserInfoViewModelInput {
    func searchWholeUserInfo()
    func touchBackButton()
    func touchSegmentControl(_ index: Int)
    func detailViewDidShow(_ index: Int)
    func touchReloadButton()
    func touchBookmarkButton()
}

protocol UserInfoViewModelOutput {
    var userName: String { get }
    var popView: PublishRelay<Void> { get }
    var currentPage: BehaviorRelay<Int> { get }
    var previousPage: BehaviorRelay<Int> { get }
    var isBookmarkUser: BehaviorRelay<Bool> { get }
    var showAlert: PublishRelay<(message: String?, isPop: Bool)> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
    var sucssesSearching: PublishRelay<Void> { get }
    var pageViewList: [UIViewController] { get }
    var changeSegment: PublishRelay<Int> { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: AppStorageable
    private let crawlManager = CrawlManager()
    private var isSearching: Bool
    
    init(storage: AppStorageable, container: Container, userName: String, isSearching: Bool) {
        self.storage = storage
        self.isSearching = isSearching
        self.isBookmarkUser = BehaviorRelay<Bool>(value: storage.isBookmarkUser(userName))
        self.userName = userName
        self.pageViewList = [container.makeBasicInfoVC(userInfo: userInfo),
                             container.makeSkillInfoViewController(skillInfo: skillInfo),
                             container.makeOwnCharacterViewController(ownCharacterInfo: ownCharacterInfo,
                                                                      userInfoViewModelDelegate: self)]
    }
    
    //in
    func searchWholeUserInfo() {
        searchUserInfo()
        getOwnCharacterInfo()
    }
    
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSegmentControl(_ index: Int) {
        currentPage.accept(index)
    }
    
    func detailViewDidShow(_ index: Int) {
        previousPage.accept(index)
    }
    
    func touchReloadButton() {
        searchWholeUserInfo()
    }
    
    func touchBookmarkButton() {
        guard let userInfo = userInfo.value else {
            return
        }
        
        do {
            if storage.isBookmarkUser(userName) {
                try storage.deleteUser(userName)
            } else {
                try storage.addUser(BookmarkUser(name: userInfo.mainInfo.name,
                                                 image: userInfo.mainInfo.userImage,
                                                 class: userInfo.mainInfo.`class`))
            }
        } catch {
            showAlert.accept((message: error.errorMessage, isPop: false))
        }
        isBookmarkUser.accept(storage.isBookmarkUser(userInfo.mainInfo.name))
    }
    
    private func mainUserUpdate(_ userInfo: UserInfo) {
        if storage.mainUser.value?.name == userInfo.mainInfo.name {
            do {
                try storage.changeMainUser(MainUser(image: userInfo.mainInfo.userImage,
                                                    battleLV: userInfo.mainInfo.battleLV,
                                                    name: userInfo.mainInfo.name,
                                                    class: userInfo.mainInfo.`class`,
                                                    itemLV: userInfo.mainInfo.itemLV,
                                                    server: userInfo.mainInfo.server))
            } catch {
                showAlert.accept((message: error.errorMessage, isPop: false))
            }
        }
    }
    
    private func bookmarkUpdate(_ userInfo: UserInfo) {
        if isBookmarkUser.value == true {
            do {
                try storage.updateUser(BookmarkUser(name: userName,
                                                    image: userInfo.mainInfo.userImage,
                                                    class: userInfo.mainInfo.`class`))
            } catch {
                showAlert.accept((message: error.errorMessage, isPop: false))
            }
        }
    }
    
    private func addRecentUser(_ userInfo: UserInfo) {
        do {
            try storage.addRecentUser(RecentUser(name: userName,
                                                 image: userInfo.mainInfo.userImage,
                                                 class: userInfo.mainInfo.`class`))
        } catch {
            showAlert.accept((message: error.errorMessage, isPop: false))
        }
    }
    
    private func searchUserInfo() {
        startedLoading.accept(())
        crawlManager.getUserInfo(userName) {[weak self] result in
            switch result {
            case .success(let userInfo):
                self?.userInfo.accept(userInfo)
                self?.skillInfo.accept(userInfo.userJsonInfo.skillInfo)
                self?.isBookmarkUser.accept(self?.storage.isBookmarkUser(userInfo.mainInfo.name) ?? false)
                self?.sucssesSearching.accept(())
                
                self?.mainUserUpdate(userInfo)
                self?.bookmarkUpdate(userInfo)
                
                if self?.isSearching == true {
                    self?.addRecentUser(userInfo)
                }
            case .failure(let error):
                self?.showAlert.accept((message: error.errorMessage, isPop: true))
            }
            self?.finishedLoading.accept(())
        }
    }
    private func getOwnCharacterInfo() {
        ownCharacterInfo.accept(nil)
        crawlManager.getOwnCharacterInfo(userName) {[weak self] result in
            switch result {
            case .success(let ownCharacterInfo):
                self?.ownCharacterInfo.accept(ownCharacterInfo)
            case .failure(let error):
                self?.showAlert.accept((message: error.errorMessage, isPop: false))
            }
        }
    }
    
    //out
    var userName: String
    let popView = PublishRelay<Void>()
    var pageViewList: [UIViewController] = []
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let isBookmarkUser: BehaviorRelay<Bool>
    let showAlert = PublishRelay<(message: String?, isPop: Bool)>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
    let sucssesSearching = PublishRelay<Void>()
    let changeSegment = PublishRelay<Int>()
    
    //for insideView
    private let userInfo = BehaviorRelay<UserInfo?>(value: nil)
    private let skillInfo = BehaviorRelay<SkillInfo?>(value: nil)
    private let ownCharacterInfo = BehaviorRelay<OwnCharacterInfo?>(value: nil)
}

//MARK: - UserInfoViewModelDelegate
extension UserInfoViewModel {
    func searchOwnCharacter(_ name: String) {
        changeSegment.accept((0))
        currentPage.accept(0)
        
        if self.userName == name {
            return
        }
        
        userName = name
        isSearching = false
        searchUserInfo()
    }
}

protocol UserInfoViewModelDelegate: AnyObject {
    func searchOwnCharacter(_ name: String)
}
