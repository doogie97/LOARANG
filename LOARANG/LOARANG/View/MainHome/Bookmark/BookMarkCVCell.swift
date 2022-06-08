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
        print("북마크 해제(nameLabel에 있는 이름 유저디폴트에서 제거 하면서 모 어쩌고 델리게이트 패턴으로라던지 콜렉션뷰 리로드 하기")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
}
