//
//  BookMarkTableViewCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

final class BookMarkTableViewCell: UITableViewCell {
    @IBOutlet private weak var bookMarkCollectionView: UICollectionView!
    
    func setTVCell() {
        bookMarkCollectionView.register(UINib(nibName: "\(BookMarkCVCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(BookMarkCVCell.self)")
        bookMarkCollectionView.dataSource = self
        bookMarkCollectionView.layer.cornerRadius = 10
        setbookMarkCVLayout()
    }
}

extension BookMarkTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BookMarkCVCell.self)", for: indexPath) as? BookMarkCVCell else { return BookMarkCVCell() }
        cell.setBookMarkCell()
        return cell
    }
}

extension BookMarkTableViewCell {
    private func setbookMarkCVLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        bookMarkCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
    }
}
