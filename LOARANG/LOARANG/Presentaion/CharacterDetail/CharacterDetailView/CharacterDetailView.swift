//
//  CharacterDetailView.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import UIKit
import SnapKit

final class CharacterDetailView: UIView {
    private weak var viewModel: CharacterDetailVMable?
    private let segmentHeight = 43.0
    private lazy var scrollableSegment = {
        let segment = ScrollableSegement(segmentTitles: ["기본 정보", "스킬", "보유캐릭터"],
                                         itemHight: segmentHeight)
        segment.delegate = self
        segment.selectedFont = .pretendard(size: 14, family: .Bold)
        segment.selectedFontColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        segment.deselectedFont = .pretendard(size: 14, family: .Regular)
        segment.underLineColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        segment.underLineHeight = 3
        
        return segment
    }()
    
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
    func changeBookmark(isBookmark: Bool) {
        navigationbar.bookmarkButton.changeBookmarkButtonColor(isBookmark)
    }
    func setViewContents(viewContents: CharacterDetailVM.ViewContents) {
        self.viewModel = viewContents.viewModel
        navigationbar.setViewContents(viewModel: viewContents.viewModel,
                                      name: viewContents.character.profile.characterName)
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(navigationbar)
        self.addSubview(scrollableSegment)
        navigationbar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        scrollableSegment.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom).inset(margin(.width, -16))
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(segmentHeight)
        }
        bringSubviewToFront(loadingView)
    }
}

extension CharacterDetailView: ScrollableSegementDelegate {
    func didSelected(_ segment: ScrollableSegement, index: Int) {
        viewModel?.touchSegment(index)
    }
}
