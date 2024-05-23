//
//  SerchView_SwiftUI.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import SwiftUI
import Kingfisher

struct SerchView_SwiftUI: View {
    private let getRecentUsersUseCase: GetRecentUsersUseCase
    
    init(getRecentUsersUseCase: GetRecentUsersUseCase) {
        self.getRecentUsersUseCase = getRecentUsersUseCase
    }
    var body: some View {
        let recentUsers = getRecentUsersUseCase.execute()
        KFImage(URL(string: recentUsers.first?.imageUrl ?? ""))
            .resizable()
            .frame(width: 20, height: 20)
    }
}

#if DEBUG
import RealmSwift
#endif
#Preview {
    let realm = try! Realm()
    let localRepository = LocalStorageRepository(realm: realm)
    let getRecentUsersUseCase = GetRecentUsersUseCase(localStorageRepository: localRepository)
    let testUser = RecentUserDTO()
    testUser.name = "테스트유저"
    testUser.characterClass = "블레이드"
    testUser.imageUrl = "https://akaikaze00.cafe24.com/web/product/big/202208/3a16878b23ad06a987ff7e5c85106598.jpg"
    try! localRepository.addRecentUser(testUser)
    let testUser2 = RecentUserDTO()
    testUser2.name = "테스트유저2"
    testUser2.characterClass = "슬레이어"
    testUser2.imageUrl = "https://randomuser.me/api/portraits/men/50.jpg"
    try! localRepository.addRecentUser(testUser2)
    return SerchView_SwiftUI(getRecentUsersUseCase: getRecentUsersUseCase)
}
