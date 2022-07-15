//
//  BookmarkTVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import Foundation
import RxRelay
import RxCocoa

final class BookmarkTVCellViewModel {
    private let storage: Storageable
    
    let bookmark: Driver<[BookmarkUser]>
    
    init(storage: Storageable) {
        self.storage = storage
        bookmark = storage.bookMark.asDriver()
    }
    
    func searchUser(_ name: String) -> UserInfo {
        return CralManager.shared.getUserInfo(name)
    }
}
