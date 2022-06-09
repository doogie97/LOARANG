//
//  BookMarkCVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

final class BookMarkCVCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override var bounds: CGRect {
         didSet {
             self.layoutIfNeeded()
         }
     }
    
    func configureCell(name: String, `class`: String) {
        nameLabel.text = name
        profileImageView.image = UIImage(named: `class` + "프로필")
        setBookMarkCell()
    }
    
    private func setBookMarkCell() {
        self.layer.cornerRadius = 10
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        nameLabel.font = UIFont.one(size: 15, family: .Bold)
    }

    @IBAction func touchStarButton(_ sender: UIButton) {
        guard let name = nameLabel.text else { return }
        BookmarkManager.shared.removeUser(name: name)
        NotificationCenter.default.post(name: Notification.Name.bookmark, object: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
}
