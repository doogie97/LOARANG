//
//  BasicInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import RxRelay
import RxSwift

protocol BasicInfoViewModelable: BasicInfoViewModelInput, BasicInfoViewModelOutput {}

protocol BasicInfoViewModelInput {
    func touchSegmentControl(_ index: Int)
    func touchEngravingCell(_ index: Int)
    func touchShareButton()
    func detailViewDidShow(_ index: Int)
}

protocol BasicInfoViewModelOutput {
    var userInfo: BehaviorRelay<UserInfo?> { get }
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

    private let disposeBag = DisposeBag()
    init(userInfo: BehaviorRelay<UserInfo?>, pageViewList: [UIViewController]) {
        self.userInfo = userInfo
        self.pageViewList = pageViewList //얘도 옮겨야됨 UserInfoViewModel처럼
        self.bind()
    }
    func bind() {
        userInfo.bind(onNext: {[weak self] in
            guard let userInfo = $0 else {
                return
            }
            
            self?.engravings.accept(userInfo.stat.engravigs)
            self?.cards.accept(userInfo.userJsonInfo.cardInfo.cards)
            self?.cardSetEffects.accept(userInfo.userJsonInfo.cardInfo.cardSetEffects)
        })
        .disposed(by: disposeBag)
    }
    //in
    func touchSegmentControl(_ index: Int) {
        currentPage.accept(index)
    }
    
    func touchEngravingCell(_ index: Int) {
        showengravingDetail.accept(engravings.value[index])
    }
    
    func touchShareButton() {
        guard let userImage = userInfo.value?.mainInfo.userImage else {
            return
        }
        
        showActivityVC.accept(userImage)
    }
    
    func detailViewDidShow(_ index: Int) {
        previousPage.accept(index)
    }
    
    //out
    let userInfo: BehaviorRelay<UserInfo?>
    let engravings = BehaviorRelay<[Engraving]>(value: [])
    let cards = BehaviorRelay<[Card]>(value: [])
    let cardSetEffects = BehaviorRelay<[CardSetEffect]>(value: [])
    let pageViewList: [UIViewController]
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
    let showengravingDetail = PublishRelay<Engraving>()
    let showActivityVC = PublishRelay<UIImage>()
}
