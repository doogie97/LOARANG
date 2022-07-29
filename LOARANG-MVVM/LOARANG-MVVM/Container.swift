//
//  Container.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

final class Container {
    private let storage: Storageable
    
    init(storage: Storageable) {
        self.storage = storage
    }
    
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel(), container: self)
    }
    
    private func makeMainViewModel() -> MainViewModel {
        return MainViewModel(storage: storage)
    }
    
    func makeBookmarkTVCellViewModel(delegate: TouchBookmarkCellDelegate) -> BookmarkTVCellViewModel {
        return BookmarkTVCellViewModel(storage: storage, delegate: delegate)
    }
    
    func makeBookmarkCVCellViewModel() -> BookmarkCVCellViewModelable {
        return BookmarkCVCellViewModel(storage: storage)
    }
    
    func makeSearchViewController() -> SearchViewController {
        return SearchViewController(viewModel: makeSearchViewModel(), container: self)
    }
    
    private func makeSearchViewModel() -> SearchViewModelable {
        return SearchViewModel()
    }
    
    func makeUserInfoViewController(_ userInfo: UserInfo) -> UserInfoViewController {
        return UserInfoViewController(viewModel: makeUserInfoViewModel(userInfo))
    }
    
    private func makeUserInfoViewModel(_ userInfo: UserInfo) -> UserInfoViewModelable {
        return UserInfoViewModel(storage: storage, userInfo: userInfo)
    }
    
}
