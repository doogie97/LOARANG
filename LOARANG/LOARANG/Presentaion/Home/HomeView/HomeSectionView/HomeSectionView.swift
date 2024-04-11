//
//  HomeSectionView.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeSectionView: UIView {
    enum SectionCase: Int, CaseIterable {
        case mainUser
        case bookmark
        case event
        case notice
    }
    
    private lazy var sectionCV = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewLayout())
    
    func setViewContents() {
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
            return 10 //viewModel의 bookmarkCount만큼
        case .event:
            return 6 //viewModel의 event수 만큼
        case .notice:
            return 8 //viewModel의 notice수 만큼 인데 최대 개수 몇 개로 할 지 고민 필요
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
            guard let bookmarkUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeBookmarkUserCVCell.self)", for: indexPath) as? HomeBookmarkUserCVCell else {
                return UICollectionViewCell()
            }
            
            bookmarkUserCell.setCellContents()
            return bookmarkUserCell
        case .event:
            guard let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeEventCVCell.self)", for: indexPath) as? HomeEventCVCell else {
                return UICollectionViewCell()
            }
            
            eventCell.setCellContents()
            return eventCell
        case .notice:
            guard let noticeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeNoticeCVCell.self)", for: indexPath) as? HomeNoticeCVCell else {
                return UICollectionViewCell()
            }
            
            noticeCell.setCellContents()
            return noticeCell
        }
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
                    return .bookmark(count: 6) //viewModel의 bookmarkCount만큼
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
}

//MARK: - Make CollectionView Layout
extension HomeSectionView {
    private func createSectionCV() -> UICollectionView {
        let layout = createSectionCVLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HomeMainUserCVCell.self, forCellWithReuseIdentifier: "\(HomeMainUserCVCell.self)")
        collectionView.register(HomeBookmarkUserCVCell.self, forCellWithReuseIdentifier: "\(HomeBookmarkUserCVCell.self)")
        collectionView.register(HomeEventCVCell.self, forCellWithReuseIdentifier: "\(HomeEventCVCell.self)")
        collectionView.register(HomeNoticeCVCell.self, forCellWithReuseIdentifier: "\(HomeNoticeCVCell.self)")
        
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
        section.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: margin(.height, 20), trailing: margin(.width, 8))
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(52))
        section.boundarySupplementaryItems = [.init(layoutSize: sectionHeaderSize,
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .topLeading)]
        
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
        section.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: margin(.height, 20), trailing: margin(.width, 8))
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(52))
        section.boundarySupplementaryItems = [.init(layoutSize: sectionHeaderSize,
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .topLeading)]
        
        return section
    }
    
    func noticeSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(315 / 393))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(315 / 393))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: margin(.height, 20), trailing: margin(.width, 8))
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(52))
        section.boundarySupplementaryItems = [.init(layoutSize: sectionHeaderSize,
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .topLeading)]
        
        return section
    }
}
