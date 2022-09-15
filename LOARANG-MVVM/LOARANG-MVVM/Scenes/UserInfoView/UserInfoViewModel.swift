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
    var pageViewList: BehaviorRelay<[UIViewController?]> { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: AppStorageable
    private let container: Container
    init(storage: AppStorageable, container: Container, userName: String) {
        self.storage = storage
        self.isBookmarkUser = BehaviorRelay<Bool>(value: storage.isBookmarkUser(userName))
        self.userName = userName
        self.container = container
    }
    
    //in
    func searchUser() {
        startedLoading.accept(())
        CrawlManager().getUserInfo(userName) {[weak self] result in
            switch result {
            case .success(let userInfo):
                self?.userInfo.accept(userInfo)
                self?.skillInfo.accept(userInfo.userJsonInfo.skillInfo)
                
                guard let userInf2o = self?.userInfo else {
                    return
                }
                
                guard let skillInfo = self?.skillInfo else {
                    return
                }
                
                self?.pageViewList.accept([self?.container.makeBasicInfoVC(userInfo: userInfo, asdf: userInf2o),
                                           self?.container.makeSkillInfoViewController(skillInfo: skillInfo),
                                           self?.container.makeFourthVC()])
            case .failure(_):
                self?.showAlert.accept("검색하신 유저가 없습니다")
            }
            self?.finishedLoading.accept(())
        }
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
            guard let error = error as? LocalStorageError else {
                showAlert.accept(nil)
                return
            }
            
            showAlert.accept(error.errorDescrption)
        }
        isBookmarkUser.accept(storage.isBookmarkUser(userInfo.mainInfo.name))
    }
    
    //out
    let userName: String
    let popView = PublishRelay<Void>()
    let pageViewList = BehaviorRelay<[UIViewController?]>(value: [])
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let isBookmarkUser: BehaviorRelay<Bool>
    let showAlert = PublishRelay<String?>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
    
    //for insideView
    private let userInfo = BehaviorRelay<UserInfo?>(value: nil)
    private let skillInfo = BehaviorRelay<SkillInfo?>(value: nil)
}
