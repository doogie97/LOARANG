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
}

protocol UserInfoViewModelOutput {
    var userInfo: UserInfo { get }
    var popView: PublishRelay<Void> { get }
    var currentPage: BehaviorRelay<Int> { get }
    var previousPage: BehaviorRelay<Int> { get }
    var detailVC: BehaviorRelay<UIViewController> { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: Storageable
    private let viewList: [UIViewController]
    let userInfo: UserInfo // 이건 나중에 제거될듯? 아마 userInfo는 얘가 받는게 아니라 container에서 각각의 detailViewModel이 필요할 것 같음
    
    init(storage: Storageable,viewList: [UIViewController], userInfo: UserInfo) {
        self.storage = storage
        self.viewList = viewList
        self.userInfo = userInfo
        self.detailVC = BehaviorRelay<UIViewController>(value: viewList.first ?? UIViewController())
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSegmentControl(_ index: Int) {
        currentPage.accept(index)
        detailVC.accept(viewList[index])
    }
    
    func detailViewDidShow(_ index: Int) {
        previousPage.accept(index)
    }
    
    //out
    let popView = PublishRelay<Void>()
    let detailVC: BehaviorRelay<UIViewController>
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
}
