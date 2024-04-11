//
//  HomeView.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    private let navigationbar = HomeNavigationbar()
    func setViewContents(viewModel: HomeVMable) {
        self.backgroundColor = .mainBackground
        navigationbar.setViewContents(viewModel: viewModel)
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(navigationbar)
        navigationbar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(margin(.height, 20))
            $0.leading.trailing.equalToSuperview()
        }
    }
}
