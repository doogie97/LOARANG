//
//  BasicEquipmentViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/19.
//

import RxRelay

protocol BasicEquipmentViewModelable: BasicEquipmentViewModelInput, BasicEquipmentViewModelOutput {}

protocol BasicEquipmentViewModelInput {}

protocol BasicEquipmentViewModelOutput {
    var battleEquips: [BattleEquipmentPart?] { get }
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
    
    //out
    let battleEquips: [BattleEquipmentPart?]
}
