//
//  HomeMainUserCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeMainUserCVCell: UICollectionViewCell {
    func setCellContents() {
        let testView = UIView()
        testView.layer.borderWidth = 1
        testView.backgroundColor = .systemOrange
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
