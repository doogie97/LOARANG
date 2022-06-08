//
//  BookMarkTableViewCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

protocol TouchCellDelegate {
    func moveToUserInfoVC(name: String)
}

final class BookMarkTVCell: UITableViewCell {
    @IBOutlet private weak var bookMarkCollectionView: UICollectionView!
    private var delegate: TouchCellDelegate?
    
    func setTVCell(vc: TouchCellDelegate) {
        bookMarkCollectionView.register(UINib(nibName: "\(BookMarkCVCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(BookMarkCVCell.self)")
        bookMarkCollectionView.dataSource = self
        bookMarkCollectionView.delegate = self
        delegate = vc
        bookMarkCollectionView.layer.cornerRadius = 10
        setbookMarkCVLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCV), name: Notification.Name.bookmark, object: nil)
    }
    
    @objc private func reloadCV() {
        bookMarkCollectionView.reloadData()
    }
}

extension BookMarkTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BookmarkManager.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BookMarkCVCell.self)", for: indexPath) as? BookMarkCVCell else { return BookMarkCVCell() }
        let users = BookmarkManager.shared.getUsersArrays()
        let name = users[0][indexPath.row]
        let `class` = users[1][indexPath.row]
        cell.configureCell(name: name, class: `class`)
        return cell
    }
}

extension BookMarkTVCell {
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
