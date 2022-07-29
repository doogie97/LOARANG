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
}

final class MainViewModel: MainViewModelInOut {
    private var storage: Storageable
    private var crawlManager: CrawlManagerable
    
    init(storage: Storageable, crawlManager: CrawlManagerable) {
        self.storage = storage
        self.crawlManager = crawlManager
    }
    
    // in
    func touchSerachButton() {
        showSearchView.accept(())
    }
    
    func touchMainUserCell() {
        guard let userInfo = crawlManager.getUserInfo(storage.mainUser ?? "") else {
            return
        }
        showUserInfo.accept(userInfo)
    }
    
    // out
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<UserInfo>()
}

//MARK: - about Delegate
extension MainViewModel: TouchBookmarkCellDelegate {
    func showUserInfo(userName: String) {
        guard let userInfo = crawlManager.getUserInfo(userName) else {
            return
        }
        showUserInfo.accept(userInfo)
    }
}
