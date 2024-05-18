//
//  CharacterDetailProfileSectionView.swift
//  LOARANG
//
//  Created by Doogie on 4/19/24.
//

import UIKit
import SnapKit

final class CharacterDetailProfileSectionView: UIView {
    private weak var viewModel: CharacterDetailVMable?
    enum ProfileSectionCase: CaseIterable {
        case basicInfo
        case equipmentEffectView
        ///배틀 장비에 악세까지 포함해 section에 표시
        case equipments
        ///Stat & Engraving
        case twoRowSection
        case gemSection
        case cardListView
        case cardEffectsView
    }
    
    private lazy var sectionCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
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

//MARK: - CollectionViewDataSource
extension CharacterDetailProfileSectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProfileSectionCase.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = ProfileSectionCase.allCases[safe: section] else {
            return 0
        }
        
        switch section {
        case .basicInfo:
            return 1
        case .equipmentEffectView:
            let characterInfo = viewModel?.characterInfoData
            if !(characterInfo?.jewelrys ?? []).contains(where: { $0.equipmentType == .팔찌 }) && characterInfo?.elixirInfo == nil && characterInfo?.transcendenceInfo == nil {
                return 0
            } else {
                return 1
            }
        case .equipments:
            return 14
        case .twoRowSection:
            return 2
        case .gemSection:
            return viewModel?.characterInfoData?.gems.count ?? 0
        case .cardListView:
            return viewModel?.characterInfoData?.cardInfo.cards.count ?? 0
        case .cardEffectsView:
            if viewModel?.characterInfoData?.cardInfo.effects.isEmpty == true {
                return 0
            } else {
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = ProfileSectionCase.allCases[safe: indexPath.section] else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .basicInfo:
            return basicInfoCell(collectionView: collectionView, indexPath: indexPath)
        case .equipmentEffectView:
            return equipmentEffectCell(collectionView: collectionView, indexPath: indexPath)
        case .equipments:
            if indexPath.row == 6 { //6번째 index는 장착 각인
                return equipEngravingCell(collectionView: collectionView, indexPath: indexPath)
            } else {
                return battleEquipmentCell(collectionView: collectionView, indexPath: indexPath)
            }
        case .twoRowSection:
            return twoRwoSectionCell(collectionView: collectionView, indexPath: indexPath)
        case .gemSection:
            return gemCell(collectionView: collectionView, indexPath: indexPath)
        case .cardListView:
            return cardCell(collectionView: collectionView, indexPath: indexPath)
        case .cardEffectsView:
            return cardEffectCell(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func basicInfoCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailBasicInfoCell.self)", for: indexPath) as? CharacterDetailBasicInfoCell,
              let profile = viewModel?.characterInfoData?.profile else {
            return UICollectionViewCell()
        }
        cell.setCellContents(profile: profile)
        return cell
    }
    
    private func equipmentEffectCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailequipmentEffectCell.self)", for: indexPath) as? CharacterDetailequipmentEffectCell,
              let characterInfo = viewModel?.characterInfoData else {
            return UICollectionViewCell()
        }
        cell.setCellContents(characterInfo: characterInfo)
        return cell
    }
    
    private func battleEquipmentCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailBattleEquipmentCell.self)", for: indexPath) as? CharacterDetailBattleEquipmentCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row < 6 { //장착 장비
            let equipment = viewModel?.characterInfoData?.battleEquipments[safe: indexPath.row]
            cell.setCellContents(equipment: equipment)
            return cell
        } else { //장착 악세
            let jwelryIndex = indexPath.row - 7
            let equipment = viewModel?.characterInfoData?.jewelrys[safe: jwelryIndex]
            cell.setCellContents(equipment: equipment)
            return cell
        }
    }
    
    private func equipEngravingCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailEquipEngravingCell.self)", for: indexPath) as? CharacterDetailEquipEngravingCell else {
            return UICollectionViewCell()
        }
        
        cell.setCellContents(engravings: viewModel?.characterInfoData?.equipEngravings ?? [])
        
        return cell
    }
    
    private func twoRwoSectionCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let characterInfo = viewModel?.characterInfoData else {
            return UICollectionViewCell()
        }
        var cell: UICollectionViewCell? {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TwoRowSectionStatCell.self)", for: indexPath) as? TwoRowSectionStatCell
                cell?.setCellContents(profileInfo: characterInfo.profile)
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TwoRowSectionEngravingCell.self)", for: indexPath) as? TwoRowSectionEngravingCell
                cell?.setCellContents(characterInfo.engravigs)
                return cell
            }
            
            return nil
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    private func gemCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailGemCell.self)", for: indexPath) as? CharacterDetailGemCell,
              let gem = viewModel?.characterInfoData?.gems[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.setCellContents(gem: gem)
        return cell
    }
    
    private func cardCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailCardCell.self)", for: indexPath) as? CharacterDetailCardCell,
              let card = viewModel?.characterInfoData?.cardInfo.cards[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.setCellContents(card: card)
        return cell
    }
    
    private func cardEffectCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailCardEffectCell.self)", for: indexPath) as? CharacterDetailCardEffectCell,
              let effects = viewModel?.characterInfoData?.cardInfo.effects else {
            return UICollectionViewCell()
        }
        cell.setCellContents(effects: effects)
        return cell
    }
}

//MARK: - CollectionViewDelegate
extension CharacterDetailProfileSectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = ProfileSectionCase.allCases[safe: indexPath.section] else {
            return
        }
        
        switch section {
        case .gemSection:
            viewModel?.touchGem()
        case .basicInfo, .equipmentEffectView, .equipments, .twoRowSection, .cardListView, .cardEffectsView:
            return
        }
    }
}

//MARK: - make CollectionView
extension CharacterDetailProfileSectionView {
    private func createSectionCV() -> UICollectionView {
        let layout = createLayout()
        layout.register(CharacterDetailCardSectionBG.self,
                        forDecorationViewOfKind: "\(CharacterDetailCardSectionBG.self)")
        layout.register(CharacterDetailGemSectionBG.self,
                        forDecorationViewOfKind: "\(CharacterDetailGemSectionBG.self)")
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CharacterDetailBasicInfoCell.self)
        collectionView.register(CharacterDetailequipmentEffectCell.self)
        collectionView.register(CharacterDetailBattleEquipmentCell.self)
        collectionView.register(CharacterDetailEquipEngravingCell.self)
        collectionView.register(TwoRowSectionStatCell.self)
        collectionView.register(TwoRowSectionEngravingCell.self)
        collectionView.register(CharacterDetailGemCell.self)
        collectionView.register(CharacterDetailCardCell.self)
        collectionView.register(CharacterDetailCardEffectCell.self)
        
        
        return collectionView
    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = ProfileSectionCase.allCases[safe: sectionIndex] else {
                return nil
            }
            
            switch section {
            case .basicInfo:
                return self?.basicInfoLayout()
            case .equipmentEffectView:
                return self?.equipmentEffectViewLayout()
            case .equipments:
                return self?.battleEquipmentLayout()
            case .twoRowSection:
                return self?.twoRowSectionLayout()
            case .gemSection:
                return self?.gemSectionLayout()
            case .cardListView:
                return self?.cardListSectionLayout()
            case .cardEffectsView:
                return self?.cartEffectsSectionLayout()
            }
        }
    }
    
    private func basicInfoLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(230))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        
        return section
    }
    
    private func equipmentEffectViewLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(85))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: 10, trailing: margin(.width, 8))
        
        return section
    }
    
    private func battleEquipmentLayout() -> NSCollectionLayoutSection {
        let itemHeightInset = 8.0
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .absolute(95 + itemHeightInset))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: margin(.width, 4), bottom: 8, trailing: margin(.width, 4))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                               heightDimension: .absolute((95 + itemHeightInset) * 7))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: margin(.width, 4), bottom: 8, trailing: margin(.width, 4))
        
        return section
    }
    
    private func twoRowSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(400))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: 16, trailing: margin(.width, 8))
        
        return section
    }
    
    private func gemSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(70),
                                              heightDimension: .absolute(70))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: margin(.width, 32) + 14 , leading: margin(.width, 8), bottom: 32, trailing: margin(.width, 8))
        let sectionBGDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "\(CharacterDetailGemSectionBG.self)")
        section.decorationItems = [sectionBGDecoration]
        
        return section
    }
    
    private func cardListSectionLayout() -> NSCollectionLayoutSection {
        let widthDimension = NSCollectionLayoutDimension.fractionalWidth(1 / 3)
        let heightDimension = NSCollectionLayoutDimension.fractionalWidth(1 / 3 * 1.44)
        let itemInset = margin(.width, 4)
        let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension,
                                              heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemInset,
                                   leading: itemInset,
                                   bottom: itemInset,
                                   trailing: itemInset)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: margin(.width, 50),
                                      leading: margin(.width, 12),
                                      bottom: margin(.width, 8),
                                      trailing: margin(.width, 12))
        let sectionBGDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "\(CharacterDetailCardSectionBG.self)")
        section.decorationItems = [sectionBGDecoration]
        return section
    }
    
    private func cartEffectsSectionLayout() -> NSCollectionLayoutSection {
        let effects = self.viewModel?.characterInfoData?.cardInfo.effects ?? []
        let count = CGFloat(effects.count)
        let headerHeight = count * (19.33 +  margin(.width, 4))
        var descriptionHight: CGFloat {
            var height = 0.0
            for effect in effects {
                let lineCount = effect.description.numberOfLines(
                    labelWidth: UIScreen.main.bounds.width - margin(.width, 48),
                    font: .pretendard(size: 14, family: .SemiBold)
                )
                
                height += CGFloat(lineCount) * 17
            }
            return height
        }
        let spacingHeight = (count - 1) * 16
        
        let finalHight = headerHeight + descriptionHight + spacingHeight + 16
        let heightDimension = NSCollectionLayoutDimension.absolute(finalHight)
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: 8, trailing: margin(.width, 8))
        
        return section
    }
}
