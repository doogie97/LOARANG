//
//  UserInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import UIKit
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
    private let changeMainUserUseCase: ChangeMainUserUseCase
    private let addBookmarkUseCase: AddBookmarkUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    private let updateBookmarkUseCase: UpdateBookmarkUseCase
    private let addRecentUserUseCase: AddRecentUserUseCase
    private let crawlManager = CrawlManager()
    private var isSearching: Bool
    
    init(changeMainUserUseCase: ChangeMainUserUseCase,
         addBookmarkUseCase: AddBookmarkUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase,
         updateBookmarkUseCase: UpdateBookmarkUseCase,
         addRecentUserUseCase: AddRecentUserUseCase,
         container: Container,
         userName: String,
         isSearching: Bool) {
        
        self.changeMainUserUseCase = changeMainUserUseCase
        self.addBookmarkUseCase = addBookmarkUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        self.updateBookmarkUseCase = updateBookmarkUseCase
        self.addRecentUserUseCase = addRecentUserUseCase
        self.isSearching = isSearching
        self.userName = userName
        self.pageViewList = [container.makeBasicInfoVC(userInfo: userInfo),
                             container.makeSkillInfoViewController(skillInfo: skillInfo),
                             container.makeCharactersViewController(userName: userName,
                                                                      userInfoViewModelDelegate: self)]
    }
    
    //in
    func searchWholeUserInfo() {
        searchUserInfo()
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
            if ViewChangeManager.shared.bookmarkUsers.value.contains(where: { $0.name == userInfo.mainInfo.name }) {
                try deleteBookmarkUseCase.execute(name: userName)
            } else {
                try addBookmarkUseCase.execute(user: BookmarkUserEntity(name: userInfo.mainInfo.name,
                                                                        imageUrl: "",
                                                                        characterClass: CharacterClass(rawValue: userInfo.mainInfo.`class`) ?? .unknown))
            }
        } catch {
            showAlert.accept((message: error.errorMessage, isPop: false))
        }
        isBookmarkUser.accept(ViewChangeManager.shared.bookmarkUsers.value.contains(where: { $0.name == userInfo.mainInfo.name }))
    }
    
    private func mainUserUpdate(_ userInfo: UserInfo) {
        if ViewChangeManager.shared.mainUser.value?.name == userInfo.mainInfo.name {
            do {
                let mainUser = MainUserEntity(imageUrl: ViewChangeManager.shared.mainUser.value?.imageUrl ?? "",
                                              image: userInfo.mainInfo.userImage,
                                              battleLV: Int(userInfo.mainInfo.battleLV) ?? 0,
                                              name: userInfo.mainInfo.name,
                                              class: userInfo.mainInfo.`class`,
                                              itemLV: userInfo.mainInfo.itemLV,
                                              expeditionLV: Int(userInfo.mainInfo.expeditionLV) ?? 0,
                                              server: userInfo.mainInfo.server)
                try changeMainUserUseCase.execute(user: mainUser)
            } catch {
                showAlert.accept((message: error.errorMessage, isPop: false))
            }
        }
    }
    
    private func bookmarkUpdate(_ userInfo: UserInfo) {
        if ViewChangeManager.shared.bookmarkUsers.value.contains(where: { $0.name == userInfo.mainInfo.name }) {
            do {
                try updateBookmarkUseCase.execute(user: BookmarkUserEntity(name: userName,
                                                                           imageUrl: "",
                                                                           characterClass: CharacterClass(rawValue: userInfo.mainInfo.`class`) ?? .unknown))
            } catch {
                showAlert.accept((message: error.errorMessage, isPop: false))
            }
        }
    }
    
    private func addRecentUser(_ userInfo: UserInfo) {
        do {
            try addRecentUserUseCase.execute(user: RecentUserEntity(name: userInfo.mainInfo.name,
                                                                    image: userInfo.mainInfo.userImage,
                                                                    class: userInfo.mainInfo.`class`))
        } catch {
            showAlert.accept((message: error.errorMessage, isPop: false))
        }
    }
    
    private func searchUserInfo() {
        startedLoading.accept(())
        Task {
            do {
                let searchResult = try await crawlManager.getUserInfo(userName)
                await MainActor.run {
                    userInfo.accept(searchResult)
                    skillInfo.accept(searchResult.userJsonInfo.skillInfo)
                    isBookmarkUser.accept(ViewChangeManager.shared.bookmarkUsers.value.contains(where: { $0.name == searchResult.mainInfo.name }))
                    userName = searchResult.mainInfo.name
                    sucssesSearching.accept(())
                    
                    mainUserUpdate(searchResult)
                    bookmarkUpdate(searchResult)
                    
                    if isSearching == true { // 검색창에서 직접 검색한 유저인지 아닌지
                        addRecentUser(searchResult)
                    }
                    finishedLoading.accept(())
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept((message: error.errorMessage, isPop: true))
                    finishedLoading.accept(())
                }
            }
        }
    }

    //out
    var userName: String
    let popView = PublishRelay<Void>()
    var pageViewList: [UIViewController] = []
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let isBookmarkUser = BehaviorRelay<Bool>(value: false)
    let showAlert = PublishRelay<(message: String?, isPop: Bool)>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
    let sucssesSearching = PublishRelay<Void>()
    let changeSegment = PublishRelay<Int>()
    
    //for insideView
    private let userInfo = BehaviorRelay<UserInfo?>(value: nil)
    private let skillInfo = BehaviorRelay<SkillInfo?>(value: nil)
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
    
    func showErrorAlert() {
        self.showAlert.accept((message: "보유 캐릭터 정보를 받아올 수 없습니다.",
                               isPop: false))
    }
}

protocol UserInfoViewModelDelegate: AnyObject {
    func searchOwnCharacter(_ name: String)
    func showErrorAlert()
}
