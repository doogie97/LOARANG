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
        case battleEquipment
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
        case .battleEquipment:
            return viewModel?.characterInfoData?.battleEquipments.count ?? 0
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
        case .battleEquipment:
            return battleEquipmentCell(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func basicInfoCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailBasicInfoCell.self)", for: indexPath) as? CharacterDetailBasicInfoCell else {
            return UICollectionViewCell()
        }
        cell.setCellContents()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CharacterDetailBattleEquipmentCell.self)", for: indexPath) as? CharacterDetailBattleEquipmentCell,
              let equipment = viewModel?.characterInfoData?.battleEquipments[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.setCellContents(equipment: equipment)
        return cell
    }
}

//MARK: - make CollectionView
extension CharacterDetailProfileSectionView {
    private func createSectionCV() -> UICollectionView {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        
        collectionView.register(CharacterDetailBasicInfoCell.self)
        collectionView.register(CharacterDetailequipmentEffectCell.self)
        collectionView.register(CharacterDetailBattleEquipmentCell.self)
        
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
            case .battleEquipment:
                return self?.battleEquipmentLayout()
            }
        }
    }
    
    private func basicInfoLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.6))
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
        item.contentInsets = .init(top: 0, leading: margin(.width, 8), bottom: 8, trailing: margin(.width, 8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        return section
    }
}
