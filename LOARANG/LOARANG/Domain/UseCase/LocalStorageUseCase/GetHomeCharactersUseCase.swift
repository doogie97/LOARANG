//
//  GetHomeCharactersUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct GetHomeCharactersUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute() -> HomeCharactersEntity {
        let mainUserDto = localStorage.mainUser()
        let bookmarkUsersDto = localStorage.bookmarkUsers()
        return HomeCharactersEntity(mainUser: mainUserDto?.toEntity,
                                    bookmarkUsers: bookmarkUsersDto.compactMap {
            return $0.toEntity
        })
    }
}
