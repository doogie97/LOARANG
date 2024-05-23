//
//  RecentUserData.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import Foundation

class RecentUserData: ObservableObject {
    private let localRepository: LocalStorageRepositoryable
    
    init(localRepository: LocalStorageRepositoryable, 
         recentUserList: [RecentUserEntity] = [RecentUserEntity]()) {
        self.localRepository = localRepository
        self.recentUserList = localRepository.recentUsers().compactMap {
            return $0.toEntity
        }
    }
    
    @Published var recentUserList: [RecentUserEntity]
}
