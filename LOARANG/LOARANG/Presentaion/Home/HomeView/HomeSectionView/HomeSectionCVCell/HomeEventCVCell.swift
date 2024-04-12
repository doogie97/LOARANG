//
//  HomeEventCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeEventCVCell: UICollectionViewCell {
    private lazy var eventImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        
        return imageView
    }()
    
    func setCellContents(event: GameEventEntity) {
        setLayout()
        self.eventImageView.setImage(event.thumbnailImgUrl)
    }
    
    private func setLayout() {
        self.contentView.addSubview(eventImageView)
        eventImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eventImageView.kf.cancelDownloadTask()
        eventImageView.image = nil
    }
}
