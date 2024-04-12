//
//  HomeSectionView.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeSectionView: UIView {
    private weak var viewModel: HomeVMable?
    private var viewContents: HomeVM.ViewContents?
    enum SectionCase: Int, CaseIterable {
        case mainUser
        case bookmark
        case challengeAbyssDungeons
        case challengeGuardianRaids
        case event
        case notice
    }
    
    private(set) lazy var sectionCV = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewLayout())
    
    func setViewContents(viewContents: HomeVM.ViewContents) {
        self.viewModel = viewContents.viewModel
        self.viewContents = viewContents
        self.sectionCV = createSectionCV()
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(sectionCV)
        sectionCV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HomeSectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionCase.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SectionCase(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .mainUser:
            return 1
        case .bookmark:
            return ViewChangeManager.shared.bookmarkUsers.value.count
        case .challengeAbyssDungeons:
            return 2
        case .challengeGuardianRaids:
            return 3
        case .event:
            return 6 //viewModel의 event수 만큼
        case .notice:
            return 5 //viewModel의 notice수 만큼 인데 최대 개수 몇 개로 할 지 고민 필요
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SectionCase(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .mainUser:
            guard let mainUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeMainUserCVCell.self)", for: indexPath) as? HomeMainUserCVCell else {
                return UICollectionViewCell()
            }
            
            mainUserCell.setCellContents()
            return mainUserCell
        case .bookmark:
            return bookmarkCell(collectionView: collectionView, indexPath: indexPath)
        case .challengeAbyssDungeons, .challengeGuardianRaids, .event:
            return homeImageCVCell(collectionView: collectionView, section: section, indexPath: indexPath)
        case .notice:
            return noticeCell(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    //MARK: - Make Cell
    private func bookmarkCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let bookmarkUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeBookmarkUserCVCell.self)", for: indexPath) as? HomeBookmarkUserCVCell,
              let userInfo = ViewChangeManager.shared.bookmarkUsers.value[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        bookmarkUserCell.setCellContents(userInfo: userInfo)
        return bookmarkUserCell
    }
    private func homeImageCVCell(collectionView: UICollectionView, section: SectionCase, indexPath: IndexPath) -> UICollectionViewCell {
        var cellData: (imageUrl: String, imageTitle: String?, textColor: UIColor)? {
            switch section {
            case .challengeAbyssDungeons:
                let abyssDungeonInfo = self.viewContents?.homeGameInfo.challengeAbyssDungeonEntity[safe: indexPath.row]
                let color = #colorLiteral(red: 0.919945538, green: 0.8131091595, blue: 0.5661830306, alpha: 1)
                return (abyssDungeonInfo?.imageUrl ?? "", abyssDungeonInfo?.name, color)
            case .challengeGuardianRaids:
                let guardianRaidInfo = self.viewContents?.homeGameInfo.challengeGuardianRaidsEntity[safe: indexPath.row]
                let color = #colorLiteral(red: 0.919945538, green: 0.8131091595, blue: 0.5661830306, alpha: 1)
                return (guardianRaidInfo?.imageUrl ?? "", guardianRaidInfo?.name, color)
            case .event:
                let guardianRaidInfo = self.viewContents?.homeGameInfo.eventList[safe: indexPath.row]
                return (guardianRaidInfo?.imageUrl ?? "", guardianRaidInfo?.endDate, .white)
            case .notice, .mainUser, .bookmark:
                return nil
            }
        }
        
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeImageCVCell.self)", for: indexPath) as? HomeImageCVCell,
              let cellData = cellData else {
            return UICollectionViewCell()
        }
        
        imageCell.setCellContents(cellData)
        return imageCell
    }
    
    private func noticeCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let noticeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeNoticeCVCell.self)", for: indexPath) as? HomeNoticeCVCell else {
            return UICollectionViewCell()
        }
        
        noticeCell.setCellContents(noticeInfo: self.viewContents?.homeGameInfo.noticeList[safe: indexPath.row])
        return noticeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = SectionCase(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HomeSectionHeader.self)", for: indexPath) as? HomeSectionHeader else {
                return UICollectionReusableView()
            }
            
            var headerCase: HomeSectionHeader.HeaderCase? {
                switch section {
                case .bookmark:
                    let count = ViewChangeManager.shared.bookmarkUsers.value.count
                    return .bookmark(count: count)
                case .challengeAbyssDungeons:
                    return .challengeAbyssDungeons
                case .challengeGuardianRaids:
                    return .challengeGuardianRaids
                case .event:
                    return .event
                case .notice:
                    return .notice
                case .mainUser:
                    return nil
                }
            }
            guard let headerCase = headerCase else {
                return UICollectionReusableView()
            }
            
            header.setViewContents(headerCase: headerCase)
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = SectionCase(rawValue: indexPath.section) else {
            return
        }
        
        switch section {
        case .mainUser:
            viewModel?.touchCell(.mainUser)
        case .bookmark:
            viewModel?.touchCell(.bookmarkUser(rowIndex: indexPath.row))
        case .event:
            viewModel?.touchCell(.event(rowIndex: indexPath.row))
        case .notice:
            viewModel?.touchCell(.notice(rowIndex: indexPath.row))
        case .challengeAbyssDungeons, .challengeGuardianRaids:
            return
        }
    }
}

//MARK: - Make CollectionView Layout
extension HomeSectionView {
    enum SectionInsetInfo {
        static let sectionBasicInset = NSDirectionalEdgeInsets(top: 0,
                                                               leading: UIView().margin(.width, 8),
                                                               bottom: 20,
                                                               trailing: UIView().margin(.width, 8))
        static let sectionBasicHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(65)),
                                                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                                                    alignment: .topLeading)
    }
    private func createSectionCV() -> UICollectionView {
        let layout = createSectionCVLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(HomeMainUserCVCell.self, forCellWithReuseIdentifier: "\(HomeMainUserCVCell.self)")
        collectionView.register(HomeBookmarkUserCVCell.self, forCellWithReuseIdentifier: "\(HomeBookmarkUserCVCell.self)")
        collectionView.register(HomeNoticeCVCell.self, forCellWithReuseIdentifier: "\(HomeNoticeCVCell.self)")
        collectionView.register(HomeImageCVCell.self, forCellWithReuseIdentifier: "\(HomeImageCVCell.self)")
        
        collectionView.register(HomeSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HomeSectionHeader.self)")
        
        return collectionView
    }
    
    private func createSectionCVLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            guard let sectionCase = SectionCase(rawValue: sectionIndex) else {
                return nil
            }
            
            switch sectionCase {
            case .mainUser:
                return self?.mainUserSectionLayout()
            case .bookmark:
                return self?.bookmarkSectionLayout()
            case .challengeAbyssDungeons:
                return self?.imageSectionLayout(imageSectionCase: .challengeAbyssDungeons)
            case .challengeGuardianRaids:
                return self?.imageSectionLayout(imageSectionCase: .challengeGuardianRaids)
            case .event:
                return self?.eventSectionLayout()
            case .notice:
                return self?.noticeSectionLayout()
            }
        }
    }
    
    func mainUserSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(315 / 393))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(315 / 393))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        return section
    }
    
    func bookmarkSectionLayout() -> NSCollectionLayoutSection {
        let itemWidthInset = margin(.width, 5)
        let cellHeight = margin(.width, 155)
        let cellWidth = itemWidthInset * 2 + cellHeight
        
        let size = NSCollectionLayoutSize(widthDimension: .absolute(cellWidth),
                                          heightDimension: .absolute(cellHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: itemWidthInset, bottom: 0, trailing: itemWidthInset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(cellWidth),
                                               heightDimension: .absolute(cellHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = SectionInsetInfo.sectionBasicInset
        section.boundarySupplementaryItems = [SectionInsetInfo.sectionBasicHeader]
        
        return section
    }
    
    enum ImageSectionCase {
        case challengeAbyssDungeons
        case challengeGuardianRaids
    }
    
    func imageSectionLayout(imageSectionCase: ImageSectionCase) -> NSCollectionLayoutSection? {
        var height: CGFloat {
            switch imageSectionCase {
            case .challengeAbyssDungeons:
                return margin(.width, 157.5) + 10
            case .challengeGuardianRaids:
                return margin(.width, 120) + 10
            }
        }
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: 10, trailing: margin(.width, 8))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = SectionInsetInfo.sectionBasicInset
        section.boundarySupplementaryItems = [SectionInsetInfo.sectionBasicHeader]
        
        return section
    }
    
    func eventSectionLayout() -> NSCollectionLayoutSection {
        let width = margin(.width, 343) + margin(.width, 8) * 2
        let height = margin(.width, 178)
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: 0, trailing: margin(.width, 8))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                               heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = SectionInsetInfo.sectionBasicInset
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [SectionInsetInfo.sectionBasicHeader]
        
        return section
    }
    
    func noticeSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(55))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: margin(.width, 12), bottom: 8, trailing: margin(.width, 12))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(55))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = SectionInsetInfo.sectionBasicInset
        section.boundarySupplementaryItems = [SectionInsetInfo.sectionBasicHeader]
        
        return section
    }
}
