//
//  BookmarkFooter.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import UIKit
import SnapKit

final class BookmarkFooter: UICollectionReusableView {
    private weak var viewModel: HomeVMable?
    
    private lazy var emptyLabel = pretendardLabel(size: 16, family: .Regular, text: "즐겨찾기에 등록된 캐릭터가 없습니다🧐\n캐릭터 검색 후 등록해 보세요!", alignment: .center, lineCount: 2)
    
    private lazy var searchButton = {
        let button = UIButton(type: .system)
        button.setTitle("캐릭터 검색하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .pretendard(size: 16, family: .Bold)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(touchSearchButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchSearchButton() {
        viewModel?.touchSearchButton()
    }
    
    func setViewContents(viewModel: HomeVMable?) {
        self.viewModel = viewModel
        setLayout()
    }
    
    private func setLayout() {
        let backView = UIView()
        backView.layer.cornerRadius = 6
        backView.backgroundColor = .cellColor
        
        self.addSubview(backView)
        backView.addSubview(emptyLabel)
        backView.addSubview(searchButton)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
            $0.bottom.equalToSuperview().inset(margin(.width, 20))
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(emptyLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 48))
            $0.height.equalTo(36)
        }
    }
}
