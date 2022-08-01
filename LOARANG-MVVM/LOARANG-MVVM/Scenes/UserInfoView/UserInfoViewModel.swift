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
}

protocol UserInfoViewModelOutput {
    var userInfo: UserInfo { get }
    var popView: PublishRelay<Void> { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: Storageable
    private let viewList: [UIViewController]
    let userInfo: UserInfo // 이건 나중에 제거될듯? 아마 userInfo는 얘가 받는게 아니라 container에서 각각의 detailViewModel이 필요할 것 같음
    
    init(storage: Storageable,viewList: [UIViewController], userInfo: UserInfo) {
        self.storage = storage
        self.viewList = viewList
        self.userInfo = userInfo
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSegmentControl(_ index: Int) {
        print(index)
    }
    
    //out
    let popView = PublishRelay<Void>()
}
