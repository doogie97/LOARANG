//
//  BasicEquipmentViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/19.
//

import RxRelay
import RxSwift

protocol BasicEquipmentViewModelable: BasicEquipmentViewModelInput, BasicEquipmentViewModelOutput {}

protocol BasicEquipmentViewModelInput {
    func touchBattleEquipmentCell(_ index: Int)
    func touchAccessaryCell(_ index: Int)
    func touchGemCell(_ index: Int)
}

protocol BasicEquipmentViewModelOutput {
    var equips: BehaviorRelay<Equips?> { get }
    var battleEquips: [EquipmentPart?] { get }
    var accessories: [EquipmentPart?] { get }
    var engraves: (EquipedEngrave?,  EquipedEngrave?) { get }
    var gems: BehaviorRelay<[Gem]> { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
    var showGemDetail: PublishRelay<Gem> { get }
}

final class BasicEquipmentViewModel: BasicEquipmentViewModelable {
    private let disposeBag = DisposeBag()
    init(equips: BehaviorRelay<Equips?>) {
        self.equips = equips
        bind()
    }
    
    private func bind() {
        equips
            .bind(onNext: { [weak self] in
                guard let equips = $0 else {
                    return
                }
                self?.battleEquips = [equips.battleEquipments.head,
                                     equips.battleEquipments.shoulder,
                                     equips.battleEquipments.top,
                                     equips.battleEquipments.bottom,
                                     equips.battleEquipments.gloves,
                                     equips.battleEquipments.weapon]
                self?.accessories = [equips.accessories.necklace,
                                    equips.accessories.firstEarring,
                                    equips.accessories.secondEarring,
                                    equips.accessories.firstRing,
                                    equips.accessories.secondRing,
                                    equips.accessories.bracelet,
                                    equips.accessories.abilityStone]
                self?.engraves = equips.engrave
                self?.gems.accept(equips.gems)
            })
            .disposed(by: disposeBag)
    }
    
    //in
    func touchBattleEquipmentCell(_ index: Int) {
        showEquipmentDetail.accept(battleEquips[index])
    }
    
    func touchAccessaryCell(_ index: Int) {
        showEquipmentDetail.accept(accessories[index])
    }
    
    func touchGemCell(_ index: Int) {
        showGemDetail.accept(gems.value[index])
    }
    
    //out
    let equips: BehaviorRelay<Equips?>
    var battleEquips: [EquipmentPart?] = []
    var accessories: [EquipmentPart?] = []
    var engraves: (EquipedEngrave?, EquipedEngrave?) = (nil, nil)
    let gems = BehaviorRelay<[Gem]>(value: [])
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
    let showGemDetail = PublishRelay<Gem>()
}
