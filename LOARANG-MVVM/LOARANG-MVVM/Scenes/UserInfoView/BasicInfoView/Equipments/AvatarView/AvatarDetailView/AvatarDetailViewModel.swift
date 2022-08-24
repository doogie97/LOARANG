//
//  AvatarDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import RxRelay

protocol AvatarDetailViewModelable: AvatarDetailViewModelInput, AvatarDetailViewModelOutput {}

protocol AvatarDetailViewModelInput {
    var equipmentInfo: EquipmentPart { get }
    var dismiss: PublishRelay<Void> { get }
}

protocol AvatarDetailViewModelOutput {
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
