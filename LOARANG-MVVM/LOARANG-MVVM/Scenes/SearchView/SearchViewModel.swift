//
//  SearchViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput {}

protocol SearchViewModelInput {
    func touchBackButton()
    func touchSearchButton(_ name: String)
}

protocol SearchViewModelOutput {
    var popView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<UserInfo> { get }
    var errorAlert: PublishRelay<String> { get }
}

final class SearchViewModel: SearchViewModelable {
    private var crawlManager: CrawlManagerable
    
    init(crawlManager: CrawlManagerable) {
        self.crawlManager = crawlManager
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSearchButton(_ name: String) {
        crawlManager.getUserInfo(name) { [weak self] result in
            switch result {
            case .success(let userInfo):
                self?.showUserInfo.accept(userInfo)
            case .failure(_):
                self?.errorAlert.accept("검색하신 유저가 없습니다.")
            }
        }
    }
    
    //out
    let popView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<UserInfo>()
    let errorAlert = PublishRelay<String>()
}
