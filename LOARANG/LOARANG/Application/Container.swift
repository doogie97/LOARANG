//
//  Container.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

final class Container {
    private let storage: AppStorageable
    private let networkManager: NetworkManagerable = NetworkManager()
    
    init(storage: AppStorageable,
         localStorage: LocalStorageable) {
        self.storage = storage
        self.localStorage = localStorage //일단 사용하는 것이 하나여야 하기에 앱 정상 작동을 위해 SceneDelegate에서 주입받음, 추후 교체 완료 후 networkManager처럼 생성으로 전환 예정
    }
    
    private lazy var networkRepository = NetworkRepository(networkManager: networkManager)
    private let localStorage: LocalStorageable
    
//MARK: - about Main View
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel(), container: self)
    }
    
    private func makeMainViewModel() -> MainViewModel {
        return MainViewModel(storage: storage, 
                             getHomeInfoUseCase: GetHomeInfoUseCase(NetworkRepository: networkRepository), 
                             getHomeCharactersUseCase: GetHomeCharactersUseCase(localStorage: localStorage), 
                             changeMainUserUseCase: ChangeMainUserUseCase(localStorage: localStorage), 
                             deleteBookmarkUseCase: DeleteBookmarkUseCase(localStorage: localStorage))
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
        return SearchViewModel(storage: storage, 
                               getRecentUsersUseCase: GetRecentUsersUseCase(localStorage: localStorage),
                               addBookmarkUseCase: AddBookmarkUseCase(localStorage: localStorage),
                               deleteBookmarkUseCase: DeleteBookmarkUseCase(localStorage: localStorage))
    }
    
//MARK: - about UserInfoView
    func makeUserInfoViewController(_ userName: String, isSearching: Bool = false) -> UserInfoViewController {
        return UserInfoViewController(viewModel: makeUserInfoViewModel(userName, isSearching: isSearching))
    }
    
    private func makeUserInfoViewModel(_ userName: String, isSearching: Bool) -> UserInfoViewModelable {
        return UserInfoViewModel(storage: storage, 
                                 changeMainUserUseCase: ChangeMainUserUseCase(localStorage: localStorage), 
                                 addBookmarkUseCase: AddBookmarkUseCase(localStorage: localStorage),
                                 deleteBookmarkUseCase: DeleteBookmarkUseCase(localStorage: localStorage), 
                                 updateBookmarkUseCase: UpdateBookmarkUseCase(localStorage: localStorage),
                                 addRecentUserUseCase: AddRecentUserUseCase(localStorage: localStorage),
                                 container: self,
                                 userName: userName,
                                 isSearching: isSearching)
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
                                     userInfoViewModelDelegate: userInfoViewModelDelegate)
    }
    
    //MARK: - about settingVIew
    func makeSettingViewModel() -> SettingViewModelable {
        return SettingViewModel(changeMainUserUseCase: ChangeMainUserUseCase(localStorage: localStorage))
    }
}

