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
}

final class RecentUserCellViewModel: RecentUserCellViewModelable {
    private let storage: AppStorageable
    private let name: String
    
    init(storage: AppStorageable, name: String) {
        self.storage = storage
        self.name = name
    }
    
    //in
    func touchDeleteButton() {
        do {
            try storage.deleteRecentUser(name)
        } catch {}
    }
    
}
