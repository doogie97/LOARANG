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
    private let homeSectionView = HomeSectionView()
    
    func setViewContents(viewModel: HomeVMable) {
        self.backgroundColor = .mainBackground
        navigationbar.setViewContents(viewModel: viewModel)
        homeSectionView.setViewContents()
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(navigationbar)
        self.addSubview(homeSectionView)
        navigationbar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(margin(.height, 20))
            $0.leading.trailing.equalToSuperview()
        }
        
        homeSectionView.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
