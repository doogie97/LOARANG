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
    func touchGemCell(_ index: Int)
}

protocol BasicEquipmentViewModelOutput {
    var battleEquips: [EquipmentPart?] { get }
    var accessories: [EquipmentPart?] { get }
    var engraves: (EquipedEngrave?,  EquipedEngrave?) { get }
    var gems: BehaviorRelay<[Gem]> { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
}

final class BasicEquipmentViewModel: BasicEquipmentViewModelable {
    init(equips: Equips) {
        self.battleEquips = [equips.battleEquipments.head,
                             equips.battleEquipments.shoulder,
                             equips.battleEquipments.top,
                             equips.battleEquipments.bottom,
                             equips.battleEquipments.gloves,
                             equips.battleEquipments.weapon]
        self.accessories = [equips.accessories.necklace,
                            equips.accessories.firstEarring,
                            equips.accessories.secondEarring,
                            equips.accessories.firstRing,
                            equips.accessories.secondRing,
                            equips.accessories.bracelet,
                            equips.accessories.abilityStone]
        self.engraves = equips.engrave
        self.gems = BehaviorRelay<[Gem]>(value: equips.gems)
    }
    
    //in
    func touchBattleEquipmentCell(_ index: Int) {
        showEquipmentDetail.accept(battleEquips[index])
    }
    
    func touchAccessaryCell(_ index: Int) {
        showEquipmentDetail.accept(accessories[index])
    }
    
    func touchGemCell(_ index: Int) {
        print(gems.value[index].name)
    }
    
    //out
    let battleEquips: [EquipmentPart?]
    let accessories: [EquipmentPart?]
    let engraves: (EquipedEngrave?, EquipedEngrave?)
    let gems: BehaviorRelay<[Gem]>
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
}
