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
    func showBookmarkUser(index: Int)
}

final class BookmarkTVCellViewModel: BookmarkTVCellViewModelable {
    private let storage: AppStorageable
    private weak var delegate: TouchBookmarkCellDelegate?
    
    init(storage: AppStorageable, delegate: TouchBookmarkCellDelegate) {
        self.storage = storage
        self.delegate = delegate
        bookmark = storage.bookMark.asDriver()
    }
    
    // in
    func touchBookmarkCell(index: Int) {
        delegate?.showBookmarkUser(index: index)
    }
    
    // out
    let bookmark: Driver<[BookmarkUser]>
}
