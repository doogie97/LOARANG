//
//  RecentUserCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/06.
//

protocol RecentUserCellViewModelable {}

protocol RecentUserCellViewModelInput {}

protocol RecentUserCellViewModelOutput {}

final class RecentUserCellViewModel: RecentUserCellViewModelable {
    private let storage: AppStorageable
    
    init(storage: AppStorageable) {
        self.storage = storage
    }
    
}
