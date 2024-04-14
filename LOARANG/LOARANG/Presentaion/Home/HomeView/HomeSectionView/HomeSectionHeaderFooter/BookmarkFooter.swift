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
    
    private lazy var emptyView = {
        let view = UIView()
        view.addSubview(emptyLabel)
        view.addSubview(searchButton)
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(emptyLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 48))
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview()
        }
        return view
    }()
    
    private lazy var emptyLabel = pretendardLabel(size: 16, family: .Regular, text: "즐겨찾기에 등록된 캐릭터가 없습니다🧐\n캐릭터 검색 후 등록해 보세요!", alignment: .center, lineCount: 2)
    
    private lazy var searchButton = {
        let button = UIButton(type: .system)
        button.setTitle("캐릭터 검색하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .pretendard(size: 14, family: .Bold)
        button.backgroundColor = #colorLiteral(red: 0.3933520469, green: 0.4040421268, blue: 0.9664957529, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(touchSearchButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchSearchButton() {
        viewModel?.touchViewAction(.search)
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
        backView.addSubview(emptyView)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
            $0.bottom.equalToSuperview().inset(margin(.width, 20))
        }
        
        emptyView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}
