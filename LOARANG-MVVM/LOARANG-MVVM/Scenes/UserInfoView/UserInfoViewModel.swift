//
//  UserInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol UserInfoViewModelable: UserInfoViewModelInput, UserInfoViewModelOutput {}

protocol UserInfoViewModelInput {
    func touchBackButton()
    func touchSegmentControl(_ index: Int)
    func detailViewDidShow(_ index: Int)
    func touchBookmarkButton()
}

protocol UserInfoViewModelOutput {
    var userInfo: UserInfo { get }
    var popView: PublishRelay<Void> { get }
    var currentPage: BehaviorRelay<Int> { get }
    var previousPage: BehaviorRelay<Int> { get }
    var isBookmarkUser: BehaviorRelay<Bool> { get }
    var showAlert: PublishRelay<String?> { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: AppStorageable
    let userInfo: UserInfo
    
    init(storage: AppStorageable, userInfo: UserInfo) {
        self.storage = storage
        self.userInfo = userInfo
        self.isBookmarkUser = BehaviorRelay<Bool>(value: storage.isBookmarkUser(userInfo.mainInfo.name))
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSegmentControl(_ index: Int) {
        currentPage.accept(index)
    }
    
    func detailViewDidShow(_ index: Int) {
        previousPage.accept(index)
    }
    
    func touchBookmarkButton() {
        do {
            if storage.isBookmarkUser(userInfo.mainInfo.name) {
                try storage.deleteUser(userInfo.mainInfo.name)
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
    let popView = PublishRelay<Void>()
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let isBookmarkUser: BehaviorRelay<Bool>
    let showAlert = PublishRelay<String?>()
}
