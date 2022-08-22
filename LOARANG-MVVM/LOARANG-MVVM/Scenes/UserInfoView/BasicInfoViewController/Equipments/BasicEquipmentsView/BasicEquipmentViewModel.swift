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
    var engraves: (EquipedEngrave?,  EquipedEngrave?) { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
}

final class BasicEquipmentViewModel: BasicEquipmentViewModelable {
    init(equipments: Equipments) {
        self.battleEquips = [equipments.battleEquipments.head,
                             equipments.battleEquipments.shoulder,
                             equipments.battleEquipments.top,
                             equipments.battleEquipments.bottom,
                             equipments.battleEquipments.gloves,
                             equipments.battleEquipments.weapon]
        self.accessories = [equipments.accessories.necklace,
                            equipments.accessories.firstEarring,
                            equipments.accessories.secondEarring,
                            equipments.accessories.firstRing,
                            equipments.accessories.secondRing,
                            equipments.accessories.bracelet,
                            equipments.accessories.abilityStone]
        self.engraves = equipments.engrave
    }
    
    //in
    func touchBattleEquipmentCell(_ index: Int) {
        showEquipmentDetail.accept(battleEquips[index])
    }
    
    func touchAccessaryCell(_ index: Int) {
        showEquipmentDetail.accept(accessories[index])
    }
    
    //out
    let battleEquips: [EquipmentPart?]
    let accessories: [EquipmentPart?]
    let engraves: (EquipedEngrave?, EquipedEngrave?)
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
}
