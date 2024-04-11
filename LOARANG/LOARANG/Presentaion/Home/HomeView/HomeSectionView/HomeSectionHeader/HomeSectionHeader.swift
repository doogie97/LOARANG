//
//  HomeBookmarkSectionHeader.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeSectionHeader: UICollectionReusableView {
    private var headerCase: HeaderCase?
    
    enum HeaderCase {
        case bookmark(count: Int)
        case event
        case notice
    }
    private lazy var topSeparator = UIView()
    private lazy var titleLabel = blackHanSansLabel()
    private lazy var bookmarkCountLabel = oneFontLabel(size: 15, color: .white)
    private lazy var moreButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = UIFont.one(size: 13, family: .Bold)
        button.addTarget(self, action: #selector(touchMoreButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchMoreButton() {
        guard let headerCase = self.headerCase else {
            return
        }
        
        switch headerCase {
        case .event:
            print("이벤트 더 보기")
        case .notice:
            print("공지사항 더 보기")
        case .bookmark(_):
            return
        }
    }
    
    func setViewContents(headerCase: HeaderCase) {
        topSeparator.backgroundColor = .tableViewColor
        self.headerCase = headerCase
        switch headerCase {
        case .bookmark(let count):
            titleLabel.text = nil
            bookmarkCountLabel.isHidden = false
            moreButton.isHidden = true
            titleLabel.text = "즐겨찾기"
            bookmarkCountLabel.text = "(\(count))"
        case .event:
            titleLabel.text = "이벤트"
        case .notice:
            titleLabel.text = "공지사항"
        }
        
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(topSeparator)
        self.addSubview(titleLabel)
        self.addSubview(bookmarkCountLabel)
        self.addSubview(moreButton)
        
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(-10)
            $0.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom)
            $0.leading.bottom.equalToSuperview()
        }
        
        bookmarkCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).inset(-2)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.headerCase = nil
        self.bookmarkCountLabel.isHidden = true
        self.moreButton.isHidden = false
    }
}
