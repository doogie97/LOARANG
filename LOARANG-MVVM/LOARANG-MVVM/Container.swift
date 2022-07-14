//
//  Container.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

final class Container {
    private let storage: Storageable
    
    init(storage: Storageable) {
        self.storage = storage
    }
    
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel(), container: self)
    }
    
    private func makeMainViewModel() -> MainViewModel {
        return MainViewModel(storage: storage)
    }
}
