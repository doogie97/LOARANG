//
//  AvatarViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

protocol AvatarViewModelable: AvatarViewModelInput, AvatarViewModelOutput {}

protocol AvatarViewModelInput {}

protocol AvatarViewModelOutput {
    var leftAvatar: [EquipmentPart?] { get }
    var rightAvatar: [EquipmentPart?] { get }
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
                            nil, //나침판
                            nil, //부적
                            nil] //문장
    }
    let leftAvatar: [EquipmentPart?]
    let rightAvatar: [EquipmentPart?]
}
