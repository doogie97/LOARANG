//
//  AvatarViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import RxRelay
import RxSwift

protocol AvatarViewModelable: AvatarViewModelInput, AvatarViewModelOutput {}

protocol AvatarViewModelInput {
    func touchLeftCell(_ index: Int)
    func touchRightCell(_ index: Int)
    func touchSpecialEquipmentCell(_ index: Int)
}

protocol AvatarViewModelOutput {
    var equips: BehaviorRelay<Equips?> { get }
    var mainAvatar: [EquipmentPart?] { get }
    var subAvatar: [EquipmentPart?] { get }
    var specialEquipment: BehaviorRelay<[EquipmentPart?]> { get }
    var showEquipmentDetail: PublishRelay<EquipmentPart?> { get }
}

final class AvatarViewModel: AvatarViewModelable {
    private let disposeBag = DisposeBag()
    init(equips: BehaviorRelay<Equips?>) {
        self.equips = equips
        bind()
    }
    
    private func bind() {
        equips.bind(onNext: { [weak self] in
            guard let equips = $0 else {
                return
            }
            
            self?.mainAvatar = [equips.avatar.mainWeaponAvatar,
                               equips.avatar.mainHeadAvatar,
                               equips.avatar.mainTopAvatar,
                               equips.avatar.mainBottomAvatar,
                               equips.avatar.instrumentAvarat,
                               equips.avatar.fisrtFaceAvarat,
                               equips.avatar.secondFaceAvarat]
            
            self?.subAvatar = [equips.avatar.subWeaponAvatar,
                              equips.avatar.subHeadAvatar,
                              equips.avatar.subTopAvatar,
                               equips.avatar.subBottomAvatar]
            
            self?.specialEquipment.accept([equips.specialEquipment.compass,
                                           equips.specialEquipment.amulet,
                                           equips.specialEquipment.emblem])
        })
        .disposed(by: disposeBag)
        
    }
    
    //in
    func touchLeftCell(_ index: Int){
        showEquipmentDetail.accept(mainAvatar[index])
    }
    
    func touchRightCell(_ index: Int){
        showEquipmentDetail.accept(subAvatar[index])
    }
    
    func touchSpecialEquipmentCell(_ index: Int) {
        showEquipmentDetail.accept(specialEquipment.value[index])
    }
    
    //out
    let equips: BehaviorRelay<Equips?>
    var mainAvatar: [EquipmentPart?] = []
    var subAvatar: [EquipmentPart?] = []
    let specialEquipment = BehaviorRelay<[EquipmentPart?]>(value: [])
    let showEquipmentDetail = PublishRelay<EquipmentPart?>()
}
