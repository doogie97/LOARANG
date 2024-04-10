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
    
}

final class RecentUserCellViewModel: RecentUserCellViewModelable {
    init(userInfo: RecentUser) {
        
    }
    
}
