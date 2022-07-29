//
//  BookmarkTVCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxCocoa
protocol BookmarkTVCellViewModelable: BookmarkTVCellViewModelInput, BookmarkTVCellViewModelOutput {}

protocol BookmarkTVCellViewModelInput {
    func touchBookmarkCell(index: Int)
}

protocol BookmarkTVCellViewModelOutput {
    var bookmark: Driver<[BookmarkUser]> { get }
    var showUserInfo: PublishRelay<String> { get }
}

final class BookmarkTVCellViewModel: BookmarkTVCellViewModelable {
    private let storage: Storageable
    
    init(storage: Storageable) {
        self.storage = storage
        bookmark = storage.bookMark.asDriver()
    }
    
    // in
    func touchBookmarkCell(index: Int) {
        let userName = storage.bookMark.value[index].name
        
        showUserInfo.accept(userName)
    }
    
    // out
    let bookmark: Driver<[BookmarkUser]>
    let showUserInfo = PublishRelay<String>()
}
