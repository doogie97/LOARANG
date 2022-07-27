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
}

final class MainViewModel: MainViewModelInOut {
    private var storage: Storageable
    
    let mainUser: String
    
    init(storage: Storageable) {
        self.storage = storage
        
        self.mainUser = storage.mainUser
    }
    
    // in
    func touchSerachButton() {
        showSearchView.accept(())
    }
    
    // out
    let showSearchView = PublishRelay<Void>()
    
    func setTableViewHeight(index: Int) -> CGFloat {
        if index == 0 {
            return UIScreen.main.bounds.width * 0.75
        }
        return UIScreen.main.bounds.width * 0.58
    }
    
    
    func makeTableViewCell(index: Int, tableView: UITableView, container: Container) -> UITableViewCell {
        if index == 0 {
            return makeMainUserTVCell(tableView)
        }
        
        if index == 1 {
            return makeBookmarkTVCell(tableView, container)
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
    
    private func makeBookmarkTVCell(_ tableView: UITableView, _ container: Container) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookmarkTVCell.self)") as? BookmarkTVCell else {
            return UITableViewCell()
        }
        cell.setContainer(container)
        return cell
    }
}
