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
    
    let mainUser: UserInfo
    let bookMark: Driver<[UserInfo]>
    
    init(storage: Storageable) {
        self.storage = storage
        
        self.mainUser = storage.mainUser
        self.bookMark = storage.bookMark.asDriver()
    }
    func makeTableViewCell(index: Int, tableView: UITableView) -> UITableViewCell {
            if index == 0 {
                return makeMainUserTVCell(tableView)
            }
            return UITableViewCell()
    }
    
    private func makeMainUserTVCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainUserTVCell.self)") as? MainUserTVCell else {
            return UITableViewCell()
        }
        return cell
    }
}
