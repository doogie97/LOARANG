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
    func setViewContents(viewContents: CharacterDetailVM.ViewContents) {
        setLayout()
    }
    
    private func setLayout() {
        
        bringSubviewToFront(loadingView)
    }
}
