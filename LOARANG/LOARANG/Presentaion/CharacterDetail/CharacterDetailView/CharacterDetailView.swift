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
    
    private var currentPageIndex: Int?
    ///빠르게 탭을 오래동안 바꾸면 앱 죽는현상 방지
    private var canChangeTab = true {
        didSet {
            scrollableSegment.isUserInteractionEnabled = canChangeTab
        }
    }
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let pageVCList = [CharacterDetailProfileVC(), CharacterDetailSkillsVC(), CharacterDetailOwnCharctersVC()]
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
    
    private lazy var pageView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackground
        
        return view
    }()
    
    func changeBookmark(isBookmark: Bool) {
        navigationbar.bookmarkButton.changeBookmarkButtonColor(isBookmark)
    }
    
    func setViewContents(viewContents: CharacterDetailVM.ViewContents) {
        self.viewModel = viewContents.viewModel
        navigationbar.setViewContents(viewModel: viewContents.viewModel,
                                      name: viewContents.character.profile.characterName)
        for vc in self.pageVCList {
            (vc as? PageViewInnerVCDelegate)?.setViewContents(viewContents: viewContents)
        }
        
        setPageView(0)
        
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(navigationbar)
        self.addSubview(scrollableSegment)
        self.addSubview(pageView)
        
        navigationbar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        scrollableSegment.snp.makeConstraints {
            $0.top.equalTo(navigationbar.snp.bottom).inset(margin(.width, -16))
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(segmentHeight)
        }
        
        pageView.snp.makeConstraints {
            $0.top.equalTo(scrollableSegment.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bringSubviewToFront(loadingView)
    }
}

extension CharacterDetailView: ScrollableSegementDelegate {
    func didSelected(_ segment: ScrollableSegement, index: Int) {
        setPageView(index)
    }
    
    private func setPageView(_ index: Int) {
        if canChangeTab == false {
            return
        }
        
        if currentPageIndex == index {
             return
        }
        
        guard let innerVC = pageVCList[safe: index] else {
            return
        }
        
        canChangeTab = false
        var direction: UIPageViewController.NavigationDirection {
            index > currentPageIndex ?? -1 ? .forward : .reverse
        }
        
        pageVC.setViewControllers([innerVC], direction: direction, animated: true)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: pageView.frame.width, height: pageView.frame.height)
        pageView.addSubview(pageVC.view)
        currentPageIndex = index
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
            self?.canChangeTab = true
        }
    }
}
