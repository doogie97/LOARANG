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
    func characterDetailVC(name: String, isSearch: Bool) -> CharacterDetailVC
    func makeSearchViewController() -> SearchViewController
    func makeWebViewViewController(url: URL, title: String) -> WebViewViewController
}

final class Container: Containerable {
    private let networkRepository = NetworkRepository(networkManager: NetworkManager())
    private let localStorageRepository: LocalStorageRepositoryable
    private let crawlManager: NewCrawlManagerable = NewCrawlManager()
    
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
    
    func characterDetailVC(name: String, isSearch: Bool) -> CharacterDetailVC {
        let viewModel = CharacterDetailVM(
            characterName: name,
            isSearch: isSearch,
            getCharacterDetailUseCase: GetCharacterDetailUseCase(networkRepository: networkRepository,
                                                                 crawlManagerable: crawlManager), 
            getOwnCharactersUseCase: GetOwnCharactersUseCase(networkRepository: networkRepository),
            changeMainUserUseCase: ChangeMainUserUseCase(localStorageRepository: localStorageRepository),
            addBookmarkUseCase: AddBookmarkUseCase(localStorageRepository: localStorageRepository),
            deleteBookmarkUseCase: DeleteBookmarkUseCase(localStorageRepository: localStorageRepository),
            updateBookmarkUseCase: UpdateBookmarkUseCase(localStorageRepository: localStorageRepository),
            addRecentUserUseCase: AddRecentUserUseCase(localStorageRepository: localStorageRepository)
        )
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
    
    //MARK: - about settingVIew
    func makeSettingViewModel() -> SettingViewModelable {
        return SettingViewModel(getCharacterDetailUseCase: GetCharacterDetailUseCase(networkRepository: networkRepository,
                                                                                     crawlManagerable: crawlManager),
                                changeMainUserUseCase: ChangeMainUserUseCase(localStorageRepository: localStorageRepository),
                                deleteMainUserUseCase: DeleteMainUserUseCase(localStorageRepository: localStorageRepository))
    }
}

