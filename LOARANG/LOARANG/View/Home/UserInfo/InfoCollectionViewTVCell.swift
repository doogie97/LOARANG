//
//  InfoPageViewTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

import UIKit

class InfoCollectionViewTVCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var menuStackView: UIStackView!
    
    private var userInfo: UserInfo?
    private var previousIndex = 10
    private var currentIndex = 0
    
    func setInitailView(info: UserInfo) {
        userInfo = info
        mainView.layer.cornerRadius = 10
        infoCollectionView.layer.cornerRadius = 10
        menuStackView.layer.cornerRadius = 10
        infoCollectionView.register(UINib(nibName: "\(BasicAbilityCVCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(BasicAbilityCVCell.self)")
        infoCollectionView.register(UINib(nibName: "\(CardSetCVCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CardSetCVCell.self)")
        
        infoCollectionView.dataSource = self
        infoCollectionView.delegate = self
        setbasicAbilityCVLayout()
    }
    
    @IBAction func touchStatButton(_ sender: UIButton) {
        if currentIndex == sender.tag {
            return
        }
        var direction: UICollectionView.ScrollPosition {
            sender.tag > previousIndex ? .right : .left
        }
        infoCollectionView.scrollToItem(at: IndexPath(row: sender.tag, section: 0), at: direction, animated: true)
        currentIndex = sender.tag
    }
}
// MARK: - about collectionview
extension InfoCollectionViewTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let user = userInfo else {
            return BasicAbilityCVCell()
        }
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BasicAbilityCVCell.self)", for: indexPath) as? BasicAbilityCVCell else {
                return BasicAbilityCVCell()
            }

            cell.configureInfo(info: user.basicAbility)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardSetCVCell.self)", for: indexPath) as? CardSetCVCell else {
                return CardSetCVCell()
            }
            return cell
        }
    }
}

extension InfoCollectionViewTVCell: UICollectionViewDelegate {
    
}

extension InfoCollectionViewTVCell {
    private func setbasicAbilityCVLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        infoCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
    }
}
