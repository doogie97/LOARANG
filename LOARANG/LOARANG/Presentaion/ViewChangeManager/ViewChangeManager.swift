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
    
    let mainUser = BehaviorRelay<MainUserEntity?>(value: nil)
    let bookmarkUsers = BehaviorRelay<[BookmarkUserEntity]>(value: [])
    let recentUsers = BehaviorRelay<[RecentUserEntity]>(value: [])
}
