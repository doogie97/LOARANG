//
//  CharacterDetailGemCell.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailGemCell: UICollectionViewCell {
    func setCellContents(gem: CharacterDetailEntity.Gem) {
        self.contentView.backgroundColor = .systemOrange
        self.contentView.layer.borderWidth = 1
        setLayout()
    }
    
    private func setLayout() {
        
    }
}
