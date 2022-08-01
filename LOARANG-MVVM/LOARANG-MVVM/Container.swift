//
//  Container.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

final class Container {
    private let storage: Storageable
    private let crawlManager: CrawlManagerable
    
    init(storage: Storageable, crawlManager: CrawlManagerable) {
        self.storage = storage
        self.crawlManager = crawlManager
    }
    
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel(), container: self)
    }
    
    private func makeMainViewModel() -> MainViewModel {
        return MainViewModel(storage: storage, crawlManager: crawlManager)
    }
    
    func makeMainUserTVCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainUserTVCell.self)") as? MainUserTVCell else {
            return UITableViewCell()
        }
        
        guard let user = crawlManager.getUserInfo(storage.mainUser ?? "") else {
            cell.setNoMainUserLayout()
            return cell
        }
        
        cell.setUserInfo(user.basicInfo)
        return cell
    }
    
    func makeBookmarkTVCell(tableView: UITableView, delegate: TouchBookmarkCellDelegate) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookmarkTVCell.self)") as? BookmarkTVCell else {
            return UITableViewCell()
        }
        cell.setContainer(container: self, delegate: delegate)
        return cell
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
        return SearchViewModel(crawlManager: crawlManager)
    }
    
    func makeUserInfoViewController(_ userInfo: UserInfo) -> UserInfoViewController {
        return UserInfoViewController(viewModel: makeUserInfoViewModel(userInfo),
                                      viewList: [makeFirstVC(), makeSecondVC(), makeThirdVC(), makeFourthVC()])
    }
    
    private func makeUserInfoViewModel(_ userInfo: UserInfo) -> UserInfoViewModelable {
        return UserInfoViewModel(storage: storage,
                                 viewList: [makeFirstVC(), makeSecondVC(), makeThirdVC(), makeFourthVC()]
                                 , userInfo: userInfo)
    }
    
    private func makeFirstVC() -> FirstInfoViewController {
        return FirstInfoViewController()
    }
    
    private func makeSecondVC() -> SecondInfoViewController {
        return SecondInfoViewController()
    }
    
    private func makeThirdVC() -> ThirdInfoViewController {
        return ThirdInfoViewController()
    }
    
    private func makeFourthVC() -> FourthInfoViewController {
        return FourthInfoViewController()
    }
    
}
