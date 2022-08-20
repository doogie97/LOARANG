//
//  BasicEquipmentViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/19.
//

import RxRelay

protocol BasicEquipmentViewModelable: BasicEquipmentViewModelInput, BasicEquipmentViewModelOutput {}

protocol BasicEquipmentViewModelInput {
    func touchCell(_ index: Int)
}

protocol BasicEquipmentViewModelOutput {
    var battleEquips: [EquipmentPart?] { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
}

final class BasicEquipmentViewModel: BasicEquipmentViewModelable {
    init(equipments: Equipments) {
        let battleEquipments = equipments.battleEquipments
        self.battleEquips = [battleEquipments.head,
                             battleEquipments.shoulder,
                             battleEquipments.top,
                             battleEquipments.bottom,
                             battleEquipments.gloves,
                             battleEquipments.weapon]
    }
    
    //in
    func touchCell(_ index: Int) {
        showEquipmentDetail.accept(battleEquips[index])
    }
    
    //out
    let battleEquips: [EquipmentPart?]
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
}
