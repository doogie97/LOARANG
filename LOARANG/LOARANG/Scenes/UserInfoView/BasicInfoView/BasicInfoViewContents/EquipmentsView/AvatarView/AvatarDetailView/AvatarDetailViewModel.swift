//
//  AvatarDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import RxRelay

protocol AvatarDetailViewModelable: AvatarDetailViewModelInput, AvatarDetailViewModelOutput {}

protocol AvatarDetailViewModelInput {
    func touchCloseButton()
}

protocol AvatarDetailViewModelOutput {
    var equipmentInfo: EquipmentPart { get }
    var dismiss: PublishRelay<Void> { get }
}

final class AvatarDetailViewModel: AvatarDetailViewModelable {
    init(equipments: EquipmentPart) {
        self.equipmentInfo = equipments
    }
    
    //in
    func touchCloseButton() {
        dismiss.accept(())
    }
    
    //out
    let equipmentInfo: EquipmentPart
    let dismiss = PublishRelay<Void>()
}
