//
//  BookmarkTVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxCocoa

final class BookmarkTVCellViewModel {
    private let storage: Storageable
    
    let bookmark: Driver<[BookmarkUser]>
    
    init(storage: Storageable) {
        self.storage = storage
        bookmark = storage.bookMark.asDriver()
    }
// 이건 일단 지금 쓰는데 없음
//    func searchUser(_ name: String) -> UserInfo {
//
//        return CralManager.shared.getUserInfo(name)
//    }
}
