//
//  HomeImageCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import UIKit
import SnapKit

final class HomeImageCVCell: UICollectionViewCell {
    func setCellContents() {
        let testView = UIView()
        testView.backgroundColor = .systemPurple
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
