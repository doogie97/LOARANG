//
//  MainViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

protocol MainViewModelInOut: MainViewModelInput, MainViewModelOutPut {}

protocol MainViewModelInput {
    func touchSerachButton()
    func touchMainUserCell()
}
protocol MainViewModelOutPut {
    var showSearchView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<UserInfo> { get }
    var mainUser: BehaviorRelay<MainUser>? { get }
}

final class MainViewModel: MainViewModelInOut {
    private var storage: AppStorageable
    private var crawlManager: CrawlManagerable
    
    init(storage: AppStorageable, crawlManager: CrawlManagerable) {
        self.storage = storage
        self.mainUser = storage.mainUser
        self.crawlManager = crawlManager
    }
    
    // in
    func touchSerachButton() {
        showSearchView.accept(())
    }
    
    func touchMainUserCell() {
        crawlManager.getUserInfo(storage.mainUser?.value.name ?? "") { [weak self] result in
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
            case .failure(_):
                return
            }
        }
    }
    
    // out
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<UserInfo>()
    let mainUser: BehaviorRelay<MainUser>?
}

//MARK: - about Delegate
extension MainViewModel: TouchBookmarkCellDelegate {
    func showUserInfo(userName: String) {
        crawlManager.getUserInfo(userName) { [weak self] result in
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
            case .failure(_):
                return
            }
        }
    }
}
