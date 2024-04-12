//
//  HomeImageCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import UIKit
import SnapKit

final class HomeImageCVCell: UICollectionViewCell {
    private var imageViewSessionTask: URLSessionTask?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        
        return imageView
    }()
    
    func setCellContents(imageUrl: String, imageTitle: String?) {
        self.imageViewSessionTask = imageView.setImage(urlString: imageUrl)
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageViewSessionTask?.suspend()
        self.imageViewSessionTask?.cancel()
        self.imageView.image = nil
    }
}
