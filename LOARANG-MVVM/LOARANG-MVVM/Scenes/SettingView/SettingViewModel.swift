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
    private let crawlManager: CrawlManagerable
    
    init(storage: AppStorageable, crawlManger: CrawlManagerable) {
        self.storage = storage
        self.crawlManager = crawlManger
    }
    
    func touchChangeMainUserCell() {
        print("touchcha")
    }
}
