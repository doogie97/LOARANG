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
        button.imageView?.tintColor = .buttonColor
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func touchButton(_ sender: UIButton) {
        if sender.tag == 0 {
            print("뒤로가기")
        }
        
        if sender.tag == 1 {
            print("북마크")
        }
    }
    
    func setViewContents(viewModel: CharacterDetailVMable?,
                         name: String) {
        self.viewModel = viewModel
        titleLabel.text = name
        bookmarkButton.setBookmarkButtonColor(true)//임시로 true전달
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(bookmarkButton)
        
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
    }
}
