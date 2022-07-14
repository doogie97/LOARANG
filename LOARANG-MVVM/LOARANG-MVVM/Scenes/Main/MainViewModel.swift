//
//  MainViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxSwift
import RxRelay
import RxCocoa

final class MainViewModel {
    private var storage: Storageable
    
    let mainUser: Driver<UserInfo>
    let bookMark: Driver<[UserInfo]>
    
    init(storage: Storageable) {
        self.storage = storage
        
        self.mainUser = storage.mainUser.asDriver()
        self.bookMark = storage.bookMark.asDriver()
    }
}
