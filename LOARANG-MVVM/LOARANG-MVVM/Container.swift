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
//MARK: - about Main View
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
        
        crawlManager.getUserInfo(storage.mainUser ?? "") { result in
            switch result {
            case .success(let userInfo):
                cell.setUserInfo(userInfo.basicInfo)
            case .failure(_):
                cell.setNoMainUserLayout()
            }
        }
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
                                                 makeSecondVC(),
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
    
    func makeUserMainInfoTVCell(tableView: UITableView, userInfo: UserInfo) -> UserMainInfoTVCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserMainInfoTVCell.self)") as? UserMainInfoTVCell else {
            return UserMainInfoTVCell()
        }
        cell.setCellContents(userInfo)
        
        return cell
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
