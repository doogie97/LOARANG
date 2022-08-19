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
    var equipments: Equipments { get }
    var battleEquips: BehaviorRelay<BattleEquipments> { get }
}

final class BasicEquipmentViewModel: BasicEquipmentViewModelable {
    init(equipments: Equipments) { //이제 나중에는 초기화 할때 equipments를 받긴 받지만 테이블 뷰에 할당해 주기 위해서 아래처럼 나눠서 할당 해줄거고 out에 있는 equipments는 필요 없어 질 듯?
        self.equipments = equipments
        self.battleEquips = BehaviorRelay<BattleEquipments>(value: equipments.battleEquipments)
    }
    
    //out
    let equipments: Equipments
    let battleEquips: BehaviorRelay<BattleEquipments>
}
