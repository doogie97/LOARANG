//
//  UserInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol UserInfoViewModelable: UserInfoViewModelInput, UserInfoViewModelOutput {}

protocol UserInfoViewModelInput {
    func searchUser()
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
    var showAlert: PublishRelay<String?> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
    var sucssesSearching: PublishRelay<Void> { get }
    var pageViewList: [UIViewController] { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: AppStorageable
    private let crawlManager = CrawlManager()
    
    init(storage: AppStorageable, container: Container, userName: String) {
        self.storage = storage
        self.isBookmarkUser = BehaviorRelay<Bool>(value: storage.isBookmarkUser(userName))
        self.userName = userName
        self.pageViewList = [container.makeBasicInfoVC(userInfo: userInfo),
                             container.makeSkillInfoViewController(skillInfo: skillInfo),
                             container.makeOwnCharacterViewController(ownCharacterInfo: ownCharacterInfo)]
    }
    
    //in
    func searchUser() {
        startedLoading.accept(())
        crawlManager.getUserInfo(userName) {[weak self] result in
            switch result {
            case .success(let userInfo):
                self?.userInfo.accept(userInfo)
                self?.skillInfo.accept(userInfo.userJsonInfo.skillInfo)
                self?.sucssesSearching.accept(())
                
                self?.mainUserUpdate(userInfo)
                self?.bookmarkUpdate(userInfo)
            case .failure(_):
                self?.showAlert.accept("검색하신 유저가 없습니다")
            }
            self?.finishedLoading.accept(())
        }
        
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
        searchUser()
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
            showAlert.accept(error.errorMessage)
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
                showAlert.accept(error.errorMessage)
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
                showAlert.accept(error.errorMessage)
            }
        }
    }
    
    private func getOwnCharacterInfo() {
        print("보유 캐릭터 가져오기 시작!") // 나중에 제거 예정
        crawlManager.getOwnCharacterInfo(userName) {[weak self] result in
            switch result {
            case .success(let ownCharacterInfo):
                self?.ownCharacterInfo.accept(ownCharacterInfo)
            case .failure(_):
                print("에러") // 나중에 제거 예정
            }
            print("보유 캐릭터 가져오기 끝!") // 나중에 제거 예정
        }
    }
    
    //out
    let userName: String
    let popView = PublishRelay<Void>()
    var pageViewList: [UIViewController] = []
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let isBookmarkUser: BehaviorRelay<Bool>
    let showAlert = PublishRelay<String?>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
    let sucssesSearching = PublishRelay<Void>()
    
    //for insideView
    private let userInfo = BehaviorRelay<UserInfo?>(value: nil)
    private let skillInfo = BehaviorRelay<SkillInfo?>(value: nil)
    private let ownCharacterInfo = BehaviorRelay<OwnCharacterInfo?>(value: nil)
}
