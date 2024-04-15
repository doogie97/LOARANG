//
//  CharacterDetailView.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import UIKit
import SnapKit

final class CharacterDetailView: UIView {
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
    private lazy var navigationbar = CharacterDetailNavigationbar()
    func setViewContents(viewContents: CharacterDetailVM.ViewContents) {
        navigationbar.setViewContents(viewModel: viewContents.viewModel,
                                      name: viewContents.character.profile.characterName)
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(navigationbar)
        navigationbar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        bringSubviewToFront(loadingView)
    }
}
