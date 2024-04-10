//
//  AppStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//
import RxRelay

protocol AppStorageable {
}

final class AppStorage: AppStorageable {
    private let localStorage: LocalStorage
    
    init(_ localStorage: LocalStorage) {
        self.localStorage = localStorage
    }
}
