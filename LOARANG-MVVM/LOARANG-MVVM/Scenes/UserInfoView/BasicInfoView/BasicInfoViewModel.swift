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
    func touchShareButton()
    func detailViewDidShow(_ index: Int)
}

protocol BasicInfoViewModelOutput {
    var userInfo: UserInfo { get }
    var engravings: BehaviorRelay<[Engraving]> { get }
    var cards: BehaviorRelay<[Card]> { get }
    var cardSetEffects: BehaviorRelay<[CardSetEffect]> { get }
    var pageViewList: [UIViewController] { get }
    var currentPage: BehaviorRelay<Int> { get }
    var previousPage: BehaviorRelay<Int> { get }
    var showengravingDetail: PublishRelay<Engraving> { get }
    var showActivityVC: PublishRelay<UIImage> { get }
}

final class BasicInfoViewModel: BasicInfoViewModelable {
    init(userInfo: UserInfo, pageViewList: [UIViewController]) {
        self.userInfo = userInfo
        self.engravings = BehaviorRelay<[Engraving]>(value: userInfo.stat.engravigs)
        self.cards = BehaviorRelay<[Card]>(value: userInfo.userJsonInfo.cardInfo.cards)
        self.cardSetEffects = BehaviorRelay<[CardSetEffect]>(value: userInfo.userJsonInfo.cardInfo.cardSetEffects)
        self.pageViewList = pageViewList
    }
    
    //in
    func touchSegmentControl(_ index: Int) {
        currentPage.accept(index)
    }
    
    func touchEngravingCell(_ index: Int) {
        showengravingDetail.accept(engravings.value[index])
    }
    
    func touchShareButton() {
        showActivityVC.accept(userInfo.mainInfo.userImage)
    }
    
    func detailViewDidShow(_ index: Int) {
        previousPage.accept(index)
    }
    
    //out
    let userInfo: UserInfo
    let engravings: BehaviorRelay<[Engraving]>
    let cards: BehaviorRelay<[Card]>
    let cardSetEffects: BehaviorRelay<[CardSetEffect]>
    let pageViewList: [UIViewController]
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let showengravingDetail = PublishRelay<Engraving>()
    let showActivityVC = PublishRelay<UIImage>()
}
