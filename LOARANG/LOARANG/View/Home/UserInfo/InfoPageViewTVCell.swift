//
//  InfoPageViewTVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

import UIKit

class InfoPageViewTVCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var menuStackView: UIStackView!
    
    private var previousIndex = 10
    private var currentIndex = 0
    
    func setInitailView() {
        mainView.layer.cornerRadius = 10
        infoCollectionView.layer.cornerRadius = 10
        menuStackView.layer.cornerRadius = 10
        infoCollectionView.register(UINib(nibName: "\(BasicAbilityCVCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(BasicAbilityCVCell.self)")
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

extension InfoPageViewTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BasicAbilityCVCell.self)", for: indexPath) as? BasicAbilityCVCell else {
            return BasicAbilityCVCell()
        }
        return cell
    }
    
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

extension InfoPageViewTVCell: UICollectionViewDelegate {
    
}
