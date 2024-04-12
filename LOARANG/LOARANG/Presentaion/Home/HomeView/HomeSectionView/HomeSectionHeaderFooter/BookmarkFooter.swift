//
//  BookmarkFooter.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import UIKit
import SnapKit

final class BookmarkFooter: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViewContents() {
        self.backgroundColor = .green
    }
    
    private func setLayout() {
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
