//
//  HomeSectionView.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeSectionView: UIView {
    private lazy var sectionCV = UICollectionView(frame: .zero,
                                                              collectionViewLayout: UICollectionViewLayout())
    
    func setViewContents() {
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(sectionCV)
        sectionCV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
