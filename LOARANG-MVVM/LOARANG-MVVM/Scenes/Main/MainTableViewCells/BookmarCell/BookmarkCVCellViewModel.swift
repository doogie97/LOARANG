//
//  BookmarkCVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

protocol BookmarkCVCellViewModelable: BookmarkCVCellViewModelInput, BookmarkCVCellViewModelOutput {}

protocol BookmarkCVCellViewModelInput {
    func touchStarButton(_ name: String)
}

protocol BookmarkCVCellViewModelOutput {}

final class BookmarkCVCellViewModel: BookmarkCVCellViewModelable {
    private let storage: Storageable
    
    init(storage: Storageable) {
        self.storage = storage
    }
    
    func touchStarButton(_ name: String) {
        storage.deleteUser(name)
    }
}
