//
//  HomeView.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .mainBackground
        self.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var loadingView = LoadingView()
    private let navigationbar = HomeNavigationbar()
    private let homeSectionView = HomeSectionView()
    
    func setViewContents(viewContents: HomeVM.ViewContents) {
        navigationbar.setViewContents(viewModel: viewContents.viewModel)
        homeSectionView.layer.opacity = 0
        homeSectionView.setViewContents(viewContents: viewContents)
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
        
        bringSubviewToFront(loadingView)
        sectionViewAnimation()
    }
    
    private func sectionViewAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.homeSectionView.layer.opacity = 1
        }
    }
}

//MARK: - Manage Home Characters
extension HomeView {
    func reloadBookmark() {
        homeSectionView.sectionCV.reloadSections(IndexSet(integer: HomeSectionView.SectionCase.bookmark.rawValue))
    }
    
    func deleteCell(_ indexPath: IndexPath) {
        homeSectionView.sectionCV.deleteItems(at: [indexPath])
    }
}
