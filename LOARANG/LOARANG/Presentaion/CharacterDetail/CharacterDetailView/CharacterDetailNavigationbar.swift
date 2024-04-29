//
//  CharacterDetailNavigationbar.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import UIKit
import SnapKit

final class CharacterDetailNavigationbar: UIView {
    private weak var viewModel: CharacterDetailVMable?
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 18, family: .Bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .white
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func touchButton(_ sender: UIButton) {
        if sender.tag == 0 {
            viewModel?.touchBackButton()
        }
        
        if sender.tag == 1 {
            viewModel?.touchBookmarkButton()
        }
        
        if sender.tag == 2 {
            viewModel?.touchMoveHomeButton()
        }
    }
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
        let name = viewModel?.characterInfoData?.profile.characterName ?? ""
        titleLabel.text = name
        bookmarkButton.changeBookmarkButtonColor(name.isBookmark)
        backButton.tag = 0
        bookmarkButton.tag = 1
        homeButton.tag = 2
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(bookmarkButton)
        self.addSubview(homeButton)
        
        backButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        homeButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(bookmarkButton.snp.leading).inset(margin(.width, -4))
            $0.width.equalTo(40)
        }
    }
}
