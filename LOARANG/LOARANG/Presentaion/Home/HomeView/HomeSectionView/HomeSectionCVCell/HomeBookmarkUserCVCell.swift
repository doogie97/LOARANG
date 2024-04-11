//
//  HomeBookmarkUserCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeBookmarkUserCVCell: UICollectionViewCell {
    func setCellContents() {
        let testView = UIView()
        testView.layer.borderWidth = 1
        testView.backgroundColor = .systemRed
        self.contentView.addSubview(testView)
        testView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        setLayout()
    }
    
    private func setLayout() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
