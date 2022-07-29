//
//  MainViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

protocol MainViewModelInOut: MainViewModelInput, MainViewModelOutPut {}

protocol MainViewModelInput {
    func touchSerachButton()
}
protocol MainViewModelOutPut {
    var showSearchView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<UserInfo> { get }
}

final class MainViewModel: MainViewModelInOut {
    private var storage: Storageable
    private var crawlManager: CrawlManagerable
    
    init(storage: Storageable, crawlManager: CrawlManagerable) {
        self.storage = storage
        self.crawlManager = crawlManager
    }
    
    // in
    func touchSerachButton() {
        showSearchView.accept(())
    }
    
    // out
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<UserInfo>()
}
//MARK: - about TableView
extension MainViewModel {
    enum TableViewConstant {
        case mainUser
        case bookmark
        
        var index: Int {
            switch self {
            case .mainUser:
                return 0
            case .bookmark:
                return 1
            }
        }
        
        var cellHeight: CGFloat {
            switch self {
            case .mainUser:
                return UIScreen.main.bounds.width * 0.75
            case .bookmark:
                return UIScreen.main.bounds.width * 0.58
            }
        }
    }
    
    func setTableViewHeight(index: Int) -> CGFloat {
        if index == TableViewConstant.mainUser.index {
            return TableViewConstant.mainUser.cellHeight
        }
        
        if index == TableViewConstant.bookmark.index {
            return TableViewConstant.bookmark.cellHeight
        }
        
        return 0
    }
    
    
    func makeTableViewCell(index: Int, tableView: UITableView, container: Container) -> UITableViewCell {
        if index == TableViewConstant.mainUser.index {
            return makeMainUserTVCell(tableView)
        }
        
        if index == TableViewConstant.bookmark.index {
            return makeBookmarkTVCell(tableView, container)
        }
        return UITableViewCell()
    }
    
    private func makeMainUserTVCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainUserTVCell.self)") as? MainUserTVCell else {
            return UITableViewCell()
        }
        
        guard let user = crawlManager.getUserInfo(storage.mainUser) else {
            return UITableViewCell()
        }
        
        cell.setUserInfo(user.basicInfo)
        return cell
    }
    
    private func makeBookmarkTVCell(_ tableView: UITableView, _ container: Container) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookmarkTVCell.self)") as? BookmarkTVCell else {
            return UITableViewCell()
        }
        cell.setContainer(container: container, delegate: self)
        return cell
    }
}

//MARK: - about Delegate
extension MainViewModel: TouchBookmarkCellDelegate {
    func showUserInfo(userName: String) {
        guard let userInfo = crawlManager.getUserInfo(userName) else {
            return
        }
        showUserInfo.accept(userInfo)
    }
}
