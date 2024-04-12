//
//  HomeImageCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import UIKit
import SnapKit

final class HomeImageCVCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        
        return imageView
    }()
    
    private lazy var imageTitleLabel = pretendardLabel(size: 16, family: .Bold, color: #colorLiteral(red: 0.919945538, green: 0.8131091595, blue: 0.5661830306, alpha: 1))
    private lazy var titleLabelView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        let backView = UIView()
        backView.backgroundColor = .black
        backView.layer.opacity = 0.7
        view.addSubview(backView)
        view.addSubview(imageTitleLabel)
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(margin(.width, 10))
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    func setCellContents(imageUrl: String, imageTitle: String?) {
        imageTitleLabel.text = imageTitle
        self.titleLabelView.isHidden = imageTitle == nil
        setLayout()
        imageView.setImage(imageUrl)
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabelView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabelView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(35)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.kf.cancelDownloadTask()
        self.imageView.image = nil
    }
}
