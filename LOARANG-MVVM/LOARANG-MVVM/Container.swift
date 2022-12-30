//
//  Container.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

final class Container {
    private let storage: AppStorageable
    private let networkManager = NetworkManager()
    
    init(storage: AppStorageable) {
        self.storage = storage
    }
    
//MARK: - about Main View
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel(), container: self)
    }
    
    private func makeMainViewModel() -> MainViewModel {
        return MainViewModel(storage: storage, networkManager: networkManager)
    }
    
    func makeBookmarkCVCellViewModel() -> BookmarkCVCellViewModelable {
        return BookmarkCVCellViewModel(storage: storage)
    }
    
//MARK: - about webView
    func makeWebViewViewController(url: URL, title: String) -> WebViewViewController {
        return WebViewViewController(viewModel: makeWebViewViewModel(url: url, title: title))
    }
    
    private func makeWebViewViewModel(url: URL, title: String) -> WebViewViewModelable {
        return WebViewViewModel(url: url, title: title)
    }
    
//MARK: - about searchView
    func makeSearchViewController() -> SearchViewController {
        return SearchViewController(viewModel: makeSearchViewModel(), container: self)
    }
    
    private func makeSearchViewModel() -> SearchViewModelable {
        return SearchViewModel(storage: storage)
    }
    
    func makeRecentUserCellViewModel(userInfo: RecentUser) -> RecentUserCellViewModelable {
        return RecentUserCellViewModel(storage: storage, userInfo: userInfo)
    }
    
//MARK: - about UserInfoView
    func makeUserInfoViewController(_ userName: String, isSearching: Bool = false) -> UserInfoViewController {
        return UserInfoViewController(viewModel: makeUserInfoViewModel(userName, isSearching: isSearching))
    }
    
    private func makeUserInfoViewModel(_ userName: String, isSearching: Bool) -> UserInfoViewModelable {
        return UserInfoViewModel(storage: storage, container: self, userName: userName, isSearching: isSearching)
    }
    //MARK: - about BasicInfoView
    func makeBasicInfoVC(userInfo: BehaviorRelay<UserInfo?>) -> BasicInfoViewController {
        return BasicInfoViewController(viewModel: makeBasicInfoViewModel(userInfo: userInfo))
    }
    
    private func makeBasicInfoViewModel(userInfo: BehaviorRelay<UserInfo?>) -> BasicInfoViewModelable {
        return BasicInfoViewModel(userInfo: userInfo, container: self)
    }
    //MARK: - about BasicEquipment
    func makeBasicEquipmentViewController(equips: BehaviorRelay<Equips?>) -> BasicEquipmentViewController {
        return BasicEquipmentViewController(viewModel: makeBasicEquipmentViewModel(equips: equips), container: self)
    }
    
    private func makeBasicEquipmentViewModel(equips: BehaviorRelay<Equips?>) -> BasicEquipmentViewModelable {
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
    func makeAvatarViewController(equips: BehaviorRelay<Equips?>) -> AvatarViewController {
        return AvatarViewController(viewModel: makeAvatarViewModel(equips: equips), container: self)
    }
    
    private func makeAvatarViewModel(equips: BehaviorRelay<Equips?>) -> AvatarViewModelable {
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
    
    //MARK: - about SkillInfoView
    func makeSkillInfoViewController(skillInfo: BehaviorRelay<SkillInfo?>) -> SkillInfoViewController {
        return SkillInfoViewController(viewModel: makeSkillInfoViewModel(skillInfo: skillInfo),
                                       container: self)
    }
    
    private func makeSkillInfoViewModel(skillInfo: BehaviorRelay<SkillInfo?>) -> SkillInfoViewModelable {
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
    
    func makeCharactersViewController(userName: String, userInfoViewModelDelegate: UserInfoViewModelDelegate) -> CharactersViewController {
        return CharactersViewController(viewModel: makeCharactersViewModel(userName: userName, userInfoViewModelDelegate: userInfoViewModelDelegate))
    }
    
    private func makeCharactersViewModel(userName: String,userInfoViewModelDelegate: UserInfoViewModelDelegate) -> CharactersViewModelable {
        return CharactersViewModel(userName: userName,
                                   networkManager: networkManager,
                                   userInfoViewModelDelegate: userInfoViewModelDelegate)
    }
    
    //MARK: - about Market
    func makeMarketViewController() -> MarketViewController {
        return MarketViewController(viewModel: makeMarketViewModel(),
                                    container: self)
    }
    
    private func makeMarketViewModel() -> MarketViewModelable {
        return MarketViewModel(networkManager: networkManager)
    }
    
    func makeMarketOptionsViewController(options: BehaviorRelay<[String]>) -> MarketOptionsViewController {
        return MarketOptionsViewController(viewModel: makeMarketOptionsViewModel(options: options))
    }
    
    private func makeMarketOptionsViewModel(options: BehaviorRelay<[String]>) -> MarketOptionsViewModelable {
        return MarketOptionsViewModel(options: options)
    }
    
    //MARK: - about settingVIew
    func makeSettingViewModel() -> SettingViewModelable {
        return SettingViewModel(storage: storage)
    }
}
