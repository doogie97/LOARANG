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
    let bookmark: Driver<[String]>
    
    init(bookmark: Driver<[String]>) {
        self.bookmark = bookmark
    }
}
