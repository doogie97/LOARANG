//
//  BasicEquipmentViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/19.
//

import RxRelay

protocol BasicEquipmentViewModelable: BasicEquipmentViewModelInput, BasicEquipmentViewModelOutput {}

protocol BasicEquipmentViewModelInput {
    func touchBattleEquipmentCell(_ index: Int)
    func touchAccessaryCell(_ index: Int)
}

protocol BasicEquipmentViewModelOutput {
    var battleEquips: [EquipmentPart?] { get }
    var accessories: [EquipmentPart?] { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
    var showAccessaryDetail: PublishRelay<EquipmentPart?> { get }
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
        self.accessories = [battleEquipments.necklace,
                            battleEquipments.firstEarring,
                            battleEquipments.secondEarring,
                            battleEquipments.firstRing,
                            battleEquipments.secondRing,
                            battleEquipments.bracelet,
                            battleEquipments.abilityStone]
    }
    
    //in
    func touchBattleEquipmentCell(_ index: Int) {
        showEquipmentDetail.accept(battleEquips[index])
    }
    
    func touchAccessaryCell(_ index: Int) {
        showAccessaryDetail.accept(accessories[index])
    }
    
    //out
    let battleEquips: [EquipmentPart?]
    let accessories: [EquipmentPart?]
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
    let showAccessaryDetail = PublishRelay<EquipmentPart?>()
}
