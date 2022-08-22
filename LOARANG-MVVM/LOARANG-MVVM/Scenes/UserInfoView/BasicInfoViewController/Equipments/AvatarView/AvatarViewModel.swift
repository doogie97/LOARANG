//
//  AvatarViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import RxRelay

protocol AvatarViewModelable: AvatarViewModelInput, AvatarViewModelOutput {}

protocol AvatarViewModelInput {
    func touchLeftCell(_ index: Int)
    func touchRightCell(_ index: Int)
}

protocol AvatarViewModelOutput {
    var leftAvatar: [EquipmentPart?] { get }
    var rightAvatar: [EquipmentPart?] { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
}

final class AvatarViewModel: AvatarViewModelable {
    init(equipments: Equipments) {
        self.leftAvatar = [equipments.avatar.mainWeaponAvatar,
                           equipments.avatar.mainHeadAvatar,
                           equipments.avatar.mainTopAvatar,
                           equipments.avatar.mainBottomAvatar,
                           equipments.avatar.instrumentAvarat,
                           equipments.avatar.fisrtFaceAvarat,
                           equipments.avatar.secondFaceAvarat]
        
        self.rightAvatar = [equipments.avatar.subWeaponAvatar,
                            equipments.avatar.subHeadAvatar,
                            equipments.avatar.subTopAvatar,
                            equipments.avatar.subBottomAvatar,
                            equipments.specialEquipment.compass,
                            equipments.specialEquipment.amulet,
                            equipments.specialEquipment.emblem]
    }
    //in
    func touchLeftCell(_ index: Int){
        showEquipmentDetail.accept(leftAvatar[index])
    }
    func touchRightCell(_ index: Int){
        showEquipmentDetail.accept(rightAvatar[index])
    }
    //out
    let leftAvatar: [EquipmentPart?]
    let rightAvatar: [EquipmentPart?]
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
}
