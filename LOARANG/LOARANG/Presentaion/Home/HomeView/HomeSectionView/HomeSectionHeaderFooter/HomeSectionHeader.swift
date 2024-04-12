//
//  HomeBookmarkSectionHeader.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit
import RxSwift

final class HomeSectionHeader: UICollectionReusableView {
    private weak var viewModel: HomeVMable?
    private var headerCase: HeaderCase?
    private var disposeBag = DisposeBag()
    
    enum HeaderCase {
        case bookmark(count: Int)
        case challengeAbyssDungeons
        case challengeGuardianRaids
        case event
        case notice
    }
    
    private lazy var topSeparator = UIView()
    private lazy var titleLabel = pretendardLabel(size: 18, family: .Bold)
    private lazy var bookmarkCountLabel = pretendardLabel(size: 16, family: .Regular)
    private lazy var moreButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = .pretendard(size: 14, family: .Regular)
        button.addTarget(self, action: #selector(touchMoreButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchMoreButton() {
        guard let headerCase = self.headerCase else {
            return
        }
        
        switch headerCase {
        case .event:
            viewModel?.touchViewAction(.moreEvent)
        case .notice:
            viewModel?.touchViewAction(.moreNotice)
        case .bookmark(_), .challengeAbyssDungeons, .challengeGuardianRaids:
            return
        }
    }
    
    func setViewContents(viewModel: HomeVMable?,
                         headerCase: HeaderCase) {
        topSeparator.backgroundColor = .tableViewColor
        self.viewModel = viewModel
        self.headerCase = headerCase
        switch headerCase {
        case .bookmark(let count):
            titleLabel.text = nil
            bookmarkCountLabel.isHidden = false
            moreButton.isHidden = true
            titleLabel.text = "즐겨찾기"
            bookmarkCountLabel.text = "(\(count))"
        case .challengeAbyssDungeons:
            moreButton.isHidden = true
            titleLabel.text = "도전 어비스 던전"
        case .challengeGuardianRaids:
            moreButton.isHidden = true
            titleLabel.text = "도전 가디언 토벌"
        case .event:
            titleLabel.text = "이벤트"
        case .notice:
            titleLabel.text = "공지사항"
        }
        bindViewChangeManager()
        setLayout()
    }
    
    private func bindViewChangeManager() {
        ViewChangeManager.shared.bookmarkUsers.withUnretained(self)
            .subscribe { owner, bookmarkUsers in
                if case .bookmark = owner.headerCase {
                    owner.bookmarkCountLabel.text = "(\(bookmarkUsers.count))"
                }
            }
            .disposed(by: disposeBag)
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
            $0.leading.equalToSuperview().inset(margin(.width, 8))
            $0.bottom.equalToSuperview()
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
        self.disposeBag = DisposeBag()
    }
}