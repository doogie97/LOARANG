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
    var showErrorAlert: PublishRelay<String?> { get }
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
    
    func touchMainUserCell() { // 대표캐릭터 기능 추가 후 여기서도 저장소 업데이트 해줘야함
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
    let showErrorAlert = PublishRelay<String?>()
}

//MARK: - about Delegate
extension MainViewModel: TouchBookmarkCellDelegate {
    func showBookmarkUser(index: Int) {
        let userName = storage.bookMark.value[index].name
        
        crawlManager.getUserInfo(userName) { [weak self] result in
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
                
                do {
                    try self?.storage.updateUser(BookmarkUser(name: userName,
                                                              image: userInfo.basicInfo.userImage,
                                                              class: userInfo.basicInfo.`class`),
                                                 index: index)
                } catch {
                    guard let error = error as? LocalStorageError else {
                        self?.showErrorAlert.accept(nil)
                        return
                    }
                    
                    self?.showErrorAlert.accept(error.errorDescrption)
                }
            case .failure(_):
                return
            }
        }
    }
}
