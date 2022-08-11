//
//  EquipmentsTVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit
protocol EquipmentsTVCellViewModelable: EquipmentsTVCellViewModelableInput,
                                        EquipmentsTVCellViewModelableOutput {}

protocol EquipmentsTVCellViewModelableInput {}

protocol EquipmentsTVCellViewModelableOutput {
    var userInfo: UserInfo { get }
    var viewList: [UIViewController] { get }
}

final class EquipmentsTVCellViewModel: EquipmentsTVCellViewModelable {
    init(userInfo: UserInfo, viewList: [UIViewController]) {
        self.userInfo = userInfo
        self.viewList = viewList
    }
    
    //out
    var userInfo: UserInfo
    var viewList: [UIViewController]
}
