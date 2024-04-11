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
        return HomeCharactersEntity(mainUser: mainUser(mainUserDto),
                                    bookmarkUsers: bookmarkUsers(bookmarkUsersDto))
    }
    
    private func mainUser(_ dto: MainUserDTO?) -> MainUserEntity? {
        guard let dto = dto else {
            return nil
        }
        let image = UIImage(data: dto.imageData) ?? UIImage()
        return MainUserEntity(image: image,
                              battleLV: dto.battleLV,
                              name: dto.name,
                              class: dto.`class`,
                              itemLV: dto.itemLV,
                              server: dto.server)
    }
    
    private func bookmarkUsers(_ dto: [BookmarkUserDTO]) -> [BookmarkUserEntity] {
        return dto.compactMap {
            let image = UIImage(data: $0.imageData) ?? UIImage()
            return BookmarkUserEntity(name: $0.name,
                                      image: image,
                                      class: $0.`class`)
        }
    }
}
