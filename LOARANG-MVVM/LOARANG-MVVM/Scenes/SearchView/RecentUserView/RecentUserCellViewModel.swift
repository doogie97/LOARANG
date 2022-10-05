//
//  RecentUserCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/06.
//

protocol RecentUserCellViewModelable {}

protocol RecentUserCellViewModelable: RecentUserCellViewModelInput, RecentUserCellViewModelOutput {}

protocol RecentUserCellViewModelInput {
    func touchDeleteButton()

protocol RecentUserCellViewModelOutput {
    var userInfo: RecentUser { get }
}

final class RecentUserCellViewModel: RecentUserCellViewModelable {
    private let storage: AppStorageable
    
    init(storage: AppStorageable, userInfo: RecentUser) {
        self.storage = storage
        self.userInfo = userInfo
    }
    
    //in
    func touchDeleteButton() {
        do {
            try storage.deleteRecentUser(userInfo.name)
        } catch {}
    }
        } catch {}
    }
    
    //out
    let userInfo: RecentUser
}
