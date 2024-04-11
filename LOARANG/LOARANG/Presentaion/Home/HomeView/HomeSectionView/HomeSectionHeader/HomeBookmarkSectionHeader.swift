//
//  HomeBookmarkSectionHeader.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeBookmarkSectionHeader: UICollectionReusableView {
    private lazy var topSeparator = UIView()
    private lazy var titleLabel = blackHanSansLabel(text: "즐겨찾기")
    private lazy var bookmarkCountLabel = oneFontLabel(size: 15, color: .white)
    
    func setViewContents(bookmarkCount: Int) {
        topSeparator.backgroundColor = .tableViewColor
        bookmarkCountLabel.text = "(\(bookmarkCount))"
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(topSeparator)
        self.addSubview(titleLabel)
        self.addSubview(bookmarkCountLabel)
        
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(-10)
            $0.height.equalTo(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom)
            $0.leading.bottom.equalToSuperview()
        }
        
        bookmarkCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).inset(-2)
        }
    }
}
