//
//  EquipmentDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/20.
//

import RxRelay

protocol EquipmentDetailViewModelable: EquipmentDetailViewModelInput, EquipmentDetailViewModelOutput {}

protocol EquipmentDetailViewModelInput {
    func touchCloseButton()
}

protocol EquipmentDetailViewModelOutput {
    var equipmentInfo: EquipmentPart { get }
    var dismiss: PublishRelay<Void> { get }
}

final class EquipmentDetailViewModel: EquipmentDetailViewModelable {
    
    init(equipmentInfo: EquipmentPart) {
        self.equipmentInfo = equipmentInfo
    }
    
    //in
    func touchCloseButton() {
        dismiss.accept(())
    }
    
    //out
    let equipmentInfo: EquipmentPart
    let dismiss = PublishRelay<Void>()
}
