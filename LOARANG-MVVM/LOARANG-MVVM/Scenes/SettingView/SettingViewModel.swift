//
//  SettingViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/10.
//

protocol SettingViewModelable: SettingViewModeInput, SettingViewModeOutput {}

protocol SettingViewModeInput {
    func touchChangeMainUserCell()
}

protocol SettingViewModeOutput {}

final class SettingViewModel: SettingViewModelable {
    private let storage: AppStorageable
    
    init(storage: AppStorageable) {
        self.storage = storage
    }
    
    func touchChangeMainUserCell() {
        print("touchcha")
    }
}
