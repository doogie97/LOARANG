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
    var equipmentInfo: BattleEquipmentPart { get }
    var dismiss: PublishRelay<Void> { get }
}

final class EquipmentDetailViewModel: EquipmentDetailViewModelable {
    
    init(equipmentInfo: BattleEquipmentPart) {
        self.equipmentInfo = equipmentInfo
    }
    
    //in
    func touchCloseButton() {
        dismiss.accept(())
    }
    
    //out
    let equipmentInfo: BattleEquipmentPart//이부분은 equipmentpartable해서 추상화 할 수 있으면 나중에 장신구 디테일 쓸 때도 재사용 가능 할듯 뷰랑 뷰모델 등등 모두 다 아마 지금 배틀이펙트 이부분도 같이 장신구 추상화 가능 할듯?
    let dismiss = PublishRelay<Void>()
}
