//
//  MainViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxSwift
import RxRelay
import RxCocoa

final class MainViewModel {
    private var storage: Storageable
    
    let mainUser: String
    let bookMark: Driver<[String]>
    
    init(storage: Storageable) {
        self.storage = storage
        
        self.mainUser = storage.mainUser
        self.bookMark = storage.bookMark.asDriver()
    }
    
    func setTableViewHeight(index: Int) -> CGFloat {
        if index == 0 {
            return UIScreen.main.bounds.width * 0.75
        }
        return UIScreen.main.bounds.width * 0.58
    }
    
    
    func makeTableViewCell(index: Int, tableView: UITableView) -> UITableViewCell {
        if index == 0 {
            return makeMainUserTVCell(tableView)
        }
        
        if index == 1 {
            return makeBookmarkTVCell(tableView)
        }
        return UITableViewCell()
    }
    
    private func makeMainUserTVCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainUserTVCell.self)") as? MainUserTVCell else {
            return UITableViewCell()
        }
        cell.setUserInfo(CralManager.shared.getUserInfo(mainUser).basicInfo)
        return cell
    }
    
    private func makeBookmarkTVCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookmarkTVCell.self)") as? BookmarkTVCell else {
            return UITableViewCell()
        }
        cell.setUserInfo(CralManager.shared.getUserInfo(mainUser).basicInfo)
        return cell
    }
}
