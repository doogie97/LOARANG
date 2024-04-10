//
//  RecentUserCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/06.
//

protocol RecentUserCellViewModelable: RecentUserCellViewModelInput, RecentUserCellViewModelOutput {}

protocol RecentUserCellViewModelInput {
}

protocol RecentUserCellViewModelOutput {
    var userInfo: RecentUser { get }
}

final class RecentUserCellViewModel: RecentUserCellViewModelable {
    init(userInfo: RecentUser) {
        self.userInfo = userInfo
    }
    
    //out
    let userInfo: RecentUser
}
