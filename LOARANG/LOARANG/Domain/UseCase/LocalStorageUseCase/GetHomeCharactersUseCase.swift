//
//  GetHomeCharactersUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct GetHomeCharactersUseCase {
    private let localStorage: LocalStorageable
    
    init(localStorage: LocalStorageable) {
        self.localStorage = localStorage
    }
    
    func execute() -> HomeCharactersEntity {
        let mainUser = localStorage.mainUser()
        return HomeCharactersEntity(mainUser: mainUser,
                                    bookmarkUsers: []) //일단 빈 배열 Return
    }
}
