//
//  BookMarkTableViewCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

class BookMarkTableViewCell: UITableViewCell {
    @IBOutlet weak var bookMarkCollectionView: UICollectionView!
    
    func regist() {
        bookMarkCollectionView.register(UINib(nibName: "BookMarkCell", bundle: nil), forCellWithReuseIdentifier: "BookMarkCell")
        bookMarkCollectionView.dataSource = self
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension BookMarkTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkCell", for: indexPath) as? BookMarkCell else { return BookMarkCell() }
        cell.justLabel.text = indexPath.row.description
        cell.backgroundColor = .systemGreen

        return cell
    }
}

extension BookMarkTableViewCell {
    func setCellLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .paging
        
        bookMarkCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
    }
}
