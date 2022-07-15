//
//  BookmarkCVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

final class BookmarkCVCellViewModel {
    private let storage: Storageable
    
    init(storage: Storageable) {
        self.storage = storage
    }
    
    func deleteBookmark(_ name: String) {
        storage.deleteUser(name)
    }
}
