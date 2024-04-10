//
//  ViewChangeManager.swift
//  LOARANG
//
//  Created by Doogie on 4/9/24.
//

import RxRelay

final class ViewChangeManager {
    static let shared = ViewChangeManager()
    private init() {}
    
    let mainUser = BehaviorRelay<MainUser?>(value: nil)
    let bookmarkUsers = BehaviorRelay<[BookmarkUser]>(value: [])
}
