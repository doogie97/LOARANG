//
//  BookMarkCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

final class BookMarkCell: UICollectionViewCell {
    @IBOutlet private weak var justLabel: UILabel!
    
    func setBookMarkCell() {
        self.backgroundColor = .systemGreen
        self.justLabel.text = ""
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
