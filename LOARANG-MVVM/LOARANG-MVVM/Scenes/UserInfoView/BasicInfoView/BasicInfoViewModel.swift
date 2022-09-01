//
//  BasicInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import RxRelay

protocol BasicInfoViewModelable: BasicInfoViewModelInput, BasicInfoViewModelOutput {}

protocol BasicInfoViewModelInput {
    func touchSegmentControl(_ index: Int)
    func touchEngravingCell(_ index: Int)
    func detailViewDidShow(_ index: Int)
}

protocol BasicInfoViewModelOutput {
    var userInfo: UserInfo { get }
    var engravings: BehaviorRelay<[Engraving]> { get }
    var pageViewList: [UIViewController] { get }
    var currentPage: BehaviorRelay<Int> { get }
    var previousPage: BehaviorRelay<Int> { get }
    var showengravingDetail: PublishRelay<Engraving> { get }
}

final class BasicInfoViewModel: BasicInfoViewModelable {
    init(userInfo: UserInfo, pageViewList: [UIViewController]) {
        self.userInfo = userInfo
        self.engravings = BehaviorRelay<[Engraving]>(value: userInfo.stat.engravigs)
        self.pageViewList = pageViewList
    }
    
    //in
    func touchSegmentControl(_ index: Int) {
        currentPage.accept(index)
    }
    
    func touchEngravingCell(_ index: Int) {
        showengravingDetail.accept(engravings.value[index])
    }
    
    func detailViewDidShow(_ index: Int) {
        previousPage.accept(index)
    }
    
    //out
    let userInfo: UserInfo
    let engravings: BehaviorRelay<[Engraving]>
    let pageViewList: [UIViewController]
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let showengravingDetail = PublishRelay<Engraving>()
}
