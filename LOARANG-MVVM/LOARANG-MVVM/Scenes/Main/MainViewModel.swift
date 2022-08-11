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
    var mainUser: BehaviorRelay<MainUser?> { get }
    var showErrorAlert: PublishRelay<String?> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
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
        startedLoading.accept(())
        crawlManager.getUserInfo(storage.mainUser.value?.name ?? "") { [weak self] result in
            self?.finishedLoading.accept(())
            
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
                
                do {
                    try self?.storage.changeMainUser(MainUser(image: userInfo.basicInfo.userImage,
                                                              battleLV: userInfo.basicInfo.battleLV,
                                                              name: userInfo.basicInfo.name,
                                                              class: userInfo.basicInfo.`class`,
                                                              itemLV: userInfo.basicInfo.itemLV,
                                                              server: userInfo.basicInfo.server))
                } catch {
                    guard let error = error as? LocalStorageError else {
                        self?.showErrorAlert.accept(nil)
                        return
                    }
                    
                    self?.showErrorAlert.accept(error.errorDescrption)
                }
            case .failure(_):
                self?.showErrorAlert.accept(nil)
                return
            }
        }
    }
    
    // out
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<UserInfo>()
    let mainUser: BehaviorRelay<MainUser?>
    let showErrorAlert = PublishRelay<String?>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
}

//MARK: - about Delegate
extension MainViewModel: TouchBookmarkCellDelegate {
    func showBookmarkUser(index: Int) {
        startedLoading.accept(())
        let userName = storage.bookMark.value[index].name
        
        crawlManager.getUserInfo(userName) { [weak self] result in
            self?.finishedLoading.accept(())
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
                
                do {
                    try self?.storage.updateUser(BookmarkUser(name: userName,
                                                              image: userInfo.basicInfo.userImage,
                                                              class: userInfo.basicInfo.`class`))
                } catch {
                    guard let error = error as? LocalStorageError else {
                        self?.showErrorAlert.accept(nil)
                        return
                    }
                    
                    self?.showErrorAlert.accept(error.errorDescrption)
                }
            case .failure(_):
                self?.showErrorAlert.accept(nil)
                return
            }
        }
    }
}
