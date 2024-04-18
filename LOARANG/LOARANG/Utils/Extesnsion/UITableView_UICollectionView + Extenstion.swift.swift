//
//  UITableView_UICollectionView + Extenstion.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type) {
        self.register(cellType, forCellReuseIdentifier: "\(cellType)")
    }
}

extension UICollectionView {
    func register(_ cellType: UICollectionViewCell.Type) {
        self.register(cellType, forCellWithReuseIdentifier: "\(cellType)")
    }
}
