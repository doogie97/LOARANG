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
    var mainAvatar: [EquipmentPart?] { get }
    var subAvatar: [EquipmentPart?] { get }
    var specialEquipment: BehaviorRelay<[EquipmentPart?]> { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
}

final class AvatarViewModel: AvatarViewModelable {
    init(equips: Equips) {
        self.mainAvatar = [equips.avatar.mainWeaponAvatar,
                           equips.avatar.mainHeadAvatar,
                           equips.avatar.mainTopAvatar,
                           equips.avatar.mainBottomAvatar,
                           equips.avatar.instrumentAvarat,
                           equips.avatar.fisrtFaceAvarat,
                           equips.avatar.secondFaceAvarat]
        
        self.subAvatar = [equips.avatar.subWeaponAvatar,
                          equips.avatar.subHeadAvatar,
                          equips.avatar.subTopAvatar,
                          equips.avatar.subBottomAvatar]
        
        self.specialEquipment = BehaviorRelay<[EquipmentPart?]>(value: [equips.specialEquipment.compass,
                                                                        equips.specialEquipment.amulet,
                                                                        equips.specialEquipment.emblem])
    }
    //in
    func touchLeftCell(_ index: Int){
        showEquipmentDetail.accept(mainAvatar[index])
    }
    func touchRightCell(_ index: Int){
        showEquipmentDetail.accept(subAvatar[index])
    }
    //out
    let mainAvatar: [EquipmentPart?]
    let subAvatar: [EquipmentPart?]
    let specialEquipment: BehaviorRelay<[EquipmentPart?]>
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
}
