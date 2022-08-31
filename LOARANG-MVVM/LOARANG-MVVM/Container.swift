//
//  Container.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

final class Container {
    private let storage: AppStorageable
    private let crawlManager: CrawlManagerable
    
    init(storage: AppStorageable, crawlManager: CrawlManagerable) {
        self.storage = storage
        self.crawlManager = crawlManager
    }
    
    func checkInspection() throws {
        do {
            try crawlManager.chenckInspection()
        } catch {
            throw CrawlError.inpection
        }
    }
    
//MARK: - about Main View
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel(), container: self)
    }
    
    private func makeMainViewModel() -> MainViewModel {
        return MainViewModel(storage: storage, crawlManager: crawlManager)
    }
    
    func makeBookmarkCVCellViewModel() -> BookmarkCVCellViewModelable {
        return BookmarkCVCellViewModel(storage: storage)
    }
    
//MARK: - about searchView
    func makeSearchViewController() -> SearchViewController {
        return SearchViewController(viewModel: makeSearchViewModel(), container: self)
    }
    
    private func makeSearchViewModel() -> SearchViewModelable {
        return SearchViewModel(crawlManager: crawlManager)
    }
    
//MARK: - about UserInfoView
    func makeUserInfoViewController(_ userInfo: UserInfo) -> UserInfoViewController {
        return UserInfoViewController(viewModel: makeUserInfoViewModel(userInfo),
                                      viewList: [makeBasicInfoVC(userInfo: userInfo),
                                                 makeSkillInfoViewController(skillInfo: userInfo.userJsonInfo.skillInfo),
                                                 makeThirdVC(),
                                                 makeFourthVC()])
    }
    
    private func makeUserInfoViewModel(_ userInfo: UserInfo) -> UserInfoViewModelable {
        return UserInfoViewModel(storage: storage, userInfo: userInfo)
    }
    //MARK: - about BasicInfoView
    private func makeBasicInfoVC(userInfo: UserInfo) -> BasicInfoViewController {
        return BasicInfoViewController(container: self,
                                       viewModel: makeBasicInfoViewModel(userInfo: userInfo))
    }
    
    private func makeBasicInfoViewModel(userInfo: UserInfo) -> BasicInfoViewModelable {
        return BasicInfoViewModel(userInfo: userInfo)
    }
    
    //MARK: - about Equipments
    func makeEquipmentsTVCellViewModel(userInfo: UserInfo) -> EquipmentsTVCellViewModelable {
        return EquipmentsTVCellViewModel(
            userInfo: userInfo,
            pageViewList: [makeBasicEquipmentViewController(equips: userInfo.userJsonInfo.equips),
                           makeAvatarViewController(equips: userInfo.userJsonInfo.equips),
                           makeCharacterImageViewController(userImage: userInfo.mainInfo.userImage)]
        )
    }
    //MARK: - about BasicEquipment
    private func makeBasicEquipmentViewController(equips: Equips) -> BasicEquipmentViewController {
        return BasicEquipmentViewController(viewModel: makeBasicEquipmentViewModel(equips: equips), container: self)
    }
    
    private func makeBasicEquipmentViewModel(equips: Equips) -> BasicEquipmentViewModelable {
        return BasicEquipmentViewModel(equips: equips)
    }
    
    func makeEquipmentDetailViewController(equipmentInfo: EquipmentPart) -> EquipmentDetailViewController {
        let detailVC = EquipmentDetailViewController(viewModel: makeEquipmentDetailViewModel(equipmentInfo: equipmentInfo))
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        return detailVC
    }
    
    private func makeEquipmentDetailViewModel(equipmentInfo: EquipmentPart) -> EquipmentDetailViewModelable {
        return EquipmentDetailViewModel(equipmentInfo: equipmentInfo)
    }

    //MARK: - about Avatar
    private func makeAvatarViewController(equips: Equips) -> AvatarViewController {
        return AvatarViewController(viewModel: makeAvatarViewModel(equips: equips), container: self)
    }
    
    private func makeAvatarViewModel(equips: Equips) -> AvatarViewModelable {
        return AvatarViewModel(equips: equips)
    }
    
    func makeAvatarDetailViewController(equipmentInfo: EquipmentPart) -> AvatarDetailViewController {
        let detailVC = AvatarDetailViewController(viewModel: makeAvatarDetailViewModel(equipmentInfo: equipmentInfo))
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        return detailVC
    }
    
    private func makeAvatarDetailViewModel(equipmentInfo: EquipmentPart) -> AvatarDetailViewModelable {
        return AvatarDetailViewModel(equipments: equipmentInfo)
    }
    //MARK: - about CharacterImage
    private func makeCharacterImageViewController(userImage: UIImage) -> CharacterImageViewController {
        return CharacterImageViewController(viewModel: makeCharacterImageViewModel(userImage: userImage))
    }
    
    private func makeCharacterImageViewModel(userImage: UIImage) -> CharacterImageViewModelable {
        return CharacterImageViewModel(userImage: userImage)
    }
    //MARK: - about Engravings
    func makeEngravingsTVCellViewModel(engravings: [Engraving]) -> EngravigsTVCellViewModelable {
        return EngravigsTVCellViewModel(engravings: engravings)
    }
    //MARK: - about SkillInfoView
    private func makeSkillInfoViewController(skillInfo: SkillInfo) -> SkillInfoViewController {
        return SkillInfoViewController(viewModel: makeSkillInfoViewModel(skillInfo: skillInfo),
                                       container: self)
    }
    
    private func makeSkillInfoViewModel(skillInfo: SkillInfo) -> SkillInfoViewModelable {
        return SkillInfoViewModel(skillInfo: skillInfo)
    }
    
    func makeSkillDetailViewController(skill: Skill) -> SkillDetailViewController {
        let detailVC = SkillDetailViewController(viewModel: makeSkillDetailViewModel(skill: skill))
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        return detailVC
    }
    
    private func makeSkillDetailViewModel(skill: Skill) -> SkillDetailViewModelable {
        return SkillDetailViewModel(skill: skill)
    }
    
    private func makeThirdVC() -> ThirdInfoViewController {
        return ThirdInfoViewController()
    }
    
    private func makeFourthVC() -> FourthInfoViewController {
        return FourthInfoViewController()
    }
    
    
    //MARK: - about settingVIew
    func makeSettingViewModel() -> SettingViewModelable {
        return SettingViewModel(storage: storage, crawlManger: crawlManager)
    }
}
