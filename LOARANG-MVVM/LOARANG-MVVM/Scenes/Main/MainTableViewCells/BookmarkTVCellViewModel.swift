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
}

protocol TouchBookmarkCellDelegate: AnyObject {
    func showUserInfo(userName: String)
}

final class BookmarkTVCellViewModel: BookmarkTVCellViewModelable {
    private let storage: Storageable
    private weak var delegate: TouchBookmarkCellDelegate?
    
    init(storage: Storageable, delegate: TouchBookmarkCellDelegate) {
        self.storage = storage
        self.delegate = delegate
        bookmark = storage.bookMark.asDriver()
    }
    
    // in
    func touchBookmarkCell(index: Int) {
        let userName = storage.bookMark.value[index].name
        
        delegate?.showUserInfo(userName: userName)
    }
    
    // out
    let bookmark: Driver<[BookmarkUser]>
}
