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
    var errorAlert: PublishRelay<Void> { get }
}

final class SearchViewModel: SearchViewModelable {
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSearchButton(_ name: String) {
        guard let user = CralManager.shared.getUserInfo(name) else {
            errorAlert.accept(())
            return
        }
        showUserInfo.accept(user)
    }
    
    //out
    let popView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<UserInfo>()
    let errorAlert = PublishRelay<Void>()
}
