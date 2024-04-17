//
//  Container.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit
import RxRelay

protocol Containerable {
    func homeVC() -> HomeVC
    func characterDetailVC(name: String) -> CharacterDetailVC
    func makeSearchViewController() -> SearchViewController
    func makeWebViewViewController(url: URL, title: String) -> WebViewViewController
    func makeUserInfoViewController(_ userName: String, isSearching: Bool) -> UserInfoViewController
}

final class Container: Containerable {
    private let networkRepository = NetworkRepository(networkManager: NetworkManager())
    private let localStorageRepository: LocalStorageRepositoryable
    private let crawlManager: NewCrawlManagerable = NewCrawlManager()
    
    private let oldCrawlManager = CrawlManager() //추후 제거 예정
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorageRepository = localStorageRepository
    }
    
//MARK: - about Main View
    func homeVC() -> HomeVC {
        let homeVM = HomeVM(getHomeGameInfoUseCase: GetHomeGameInfoUseCase(networkRepository: networkRepository),
                            getHomeCharactersUseCase: GetHomeCharactersUseCase(localStorageRepository: localStorageRepository), deleteBookmarkUseCase: DeleteBookmarkUseCase(localStorageRepository: localStorageRepository),
                            getCharacterDetailUseCase: GetCharacterDetailUseCase(networkRepository: networkRepository,
                                                                                 crawlManagerable: crawlManager),
                            changeMainUserUseCase: ChangeMainUserUseCase(localStorageRepository: localStorageRepository))
        return HomeVC(container: self,
                      viewModel: homeVM)
    }
    
    func characterDetailVC(name: String) -> CharacterDetailVC {
        let viewModel = CharacterDetailVM(characterName: name,
                                          getCharacterDetailUseCase: GetCharacterDetailUseCase(networkRepository: networkRepository,
                                                                                               crawlManagerable: crawlManager))
        return CharacterDetailVC(container: self,
                                 viewModel: viewModel)
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
        return SearchViewModel(getRecentUsersUseCase: GetRecentUsersUseCase(localStorageRepository: localStorageRepository),
                               addBookmarkUseCase: AddBookmarkUseCase(localStorageRepository: localStorageRepository),
                               deleteBookmarkUseCase: DeleteBookmarkUseCase(localStorageRepository: localStorageRepository),
                               deleteRecentUserUseCase: DeleteRecentUserUseCase(localStorageRepository: localStorageRepository))
    }
    
//MARK: - about UserInfoView
    func makeUserInfoViewController(_ userName: String, isSearching: Bool = false) -> UserInfoViewController {
        return UserInfoViewController(viewModel: makeUserInfoViewModel(userName, isSearching: isSearching))
    }
    
    private func makeUserInfoViewModel(_ userName: String, isSearching: Bool) -> UserInfoViewModelable {
        return UserInfoViewModel(changeMainUserUseCase: ChangeMainUserUseCase(localStorageRepository: localStorageRepository), 
                                 addBookmarkUseCase: AddBookmarkUseCase(localStorageRepository: localStorageRepository),
                                 deleteBookmarkUseCase: DeleteBookmarkUseCase(localStorageRepository: localStorageRepository), 
                                 updateBookmarkUseCase: UpdateBookmarkUseCase(localStorageRepository: localStorageRepository),
                                 addRecentUserUseCase: AddRecentUserUseCase(localStorageRepository: localStorageRepository),
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
        return SkillInfoViewController()
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
        return SettingViewModel(getCharacterDetailUseCase: GetCharacterDetailUseCase(networkRepository: networkRepository,
                                                                                     crawlManagerable: crawlManager),
                                changeMainUserUseCase: ChangeMainUserUseCase(localStorageRepository: localStorageRepository),
                                deleteMainUserUseCase: DeleteMainUserUseCase(localStorageRepository: localStorageRepository))
    }
}

