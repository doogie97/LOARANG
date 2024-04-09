//
//  GetHomeCharactersUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct GetHomeCharactersUseCase {
    private let localStorageable: LocalStorageable
    
    init(localStorageable: LocalStorageable) {
        self.localStorageable = localStorageable
    }
    
    func execute() -> HomeCharactersEntity {
        let mainUser = localStorageable.mainUser()
        return HomeCharactersEntity(mainUser: mainUser,
                                    bookmarkUsers: []) //일단 빈 배열 Return
    }
}
