//
//  CharacterDetailOwnCharacterCell.swift
//  LOARANG
//
//  Created by Doogie on 4/18/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailOwnCharacterCell: UITableViewCell {
    private lazy var backView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        view.addSubview(classImageView)
        classImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(40)
            $0.width.equalTo(classImageView.snp.height)
        }
        
        return view
    }()
    
    private lazy var classImageView = UIImageView()
    
    func setCellContents(_ character: OwnCharactersEntity.Character) {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        classImageView.setImage(character.characterClass.classImageURL)
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            let inset = margin(.width, 8)
            $0.top.leading.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview()
        }
   
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        classImageView.kf.cancelDownloadTask()
        classImageView.image = nil
    }
}
