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
    init(equips: Equips) {
        self.leftAvatar = [equips.avatar.mainWeaponAvatar,
                           equips.avatar.mainHeadAvatar,
                           equips.avatar.mainTopAvatar,
                           equips.avatar.mainBottomAvatar,
                           equips.avatar.instrumentAvarat,
                           equips.avatar.fisrtFaceAvarat,
                           equips.avatar.secondFaceAvarat]
        
        self.rightAvatar = [equips.avatar.subWeaponAvatar,
                            equips.avatar.subHeadAvatar,
                            equips.avatar.subTopAvatar,
                            equips.avatar.subBottomAvatar,
                            equips.specialEquipment.compass,
                            equips.specialEquipment.amulet,
                            equips.specialEquipment.emblem]
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
