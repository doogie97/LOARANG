//
//  EquipmentsTVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import RxRelay
protocol EquipmentsTVCellViewModelable: EquipmentsTVCellViewModelableInput,
                                        EquipmentsTVCellViewModelableOutput {}

protocol EquipmentsTVCellViewModelableInput {
    func touchSegmentControl(_ index: Int)
    func detailViewDidShow(_ index: Int)
}

protocol EquipmentsTVCellViewModelableOutput {
    var userInfo: UserInfo { get } //이건 필요 없을지도 각 뷰컨 생성할 때 컨테이너에서 넣주면 되니까
    var pageViewList: [UIViewController] { get }
    var currentPage: BehaviorRelay<Int> { get }
    var previousPage: BehaviorRelay<Int> { get }
}

final class EquipmentsTVCellViewModel: EquipmentsTVCellViewModelable {
    init(userInfo: UserInfo, pageViewList: [UIViewController]) {
        self.userInfo = userInfo
        self.pageViewList = pageViewList
    }
    //in
    func touchSegmentControl(_ index: Int) {
        currentPage.accept(index)
    }
    
    func detailViewDidShow(_ index: Int) {
        previousPage.accept(index)
    }
    
    //out
    let userInfo: UserInfo
    let pageViewList: [UIViewController]
    let currentPage = BehaviorRelay<Int>(value: 0)
    let previousPage = BehaviorRelay<Int>(value: 50)
}
