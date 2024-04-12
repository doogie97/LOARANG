//
//  HomeBookmarkUserCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit
import RxSwift

final class HomeBookmarkUserCVCell: UICollectionViewCell {
    private var indexPath: IndexPath?
    private weak var viewModel: HomeVMable?
    private var disposeBag = DisposeBag()
    
    private lazy var imageWidth = margin(.width, 85)
    private lazy var characterImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.2
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageWidth / 2
        
        return imageView
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchStarButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchStarButton() {
        guard let indexPath = self.indexPath else {
            return
        }
        viewModel?.touchCell(.bookmarkStarButton(rowIndex: indexPath.row))
    }
    
    private lazy var characterNameLabel = pretendardLabel(size: 16, alignment: .center)
    
    func setCellContents(indexPath: IndexPath,
                         viewModel: HomeVMable?,
                         userInfo: BookmarkUserEntity) {
        self.indexPath = indexPath
        self.viewModel = viewModel
        self.contentView.backgroundColor = .cellColor
        self.characterImageView.image = userInfo.image.cropImage(class: userInfo.class)
        self.characterNameLabel.text = userInfo.name
        self.contentView.layer.cornerRadius = 6
        bindViewModel()
        setLayout()
    }
    
    private func bindViewModel() {
        viewModel?.deleteBookmarkCell.withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                guard let oldIndexPath = self.indexPath else {
                    return
                }
                if indexPath.row < oldIndexPath.row {
                    self.indexPath = IndexPath(item: oldIndexPath.row - 1, section: oldIndexPath.section)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        self.contentView.addSubview(characterImageView)
        self.contentView.addSubview(bookmarkButton)
        self.contentView.addSubview(characterNameLabel)
        
        characterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.width, 24))
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(imageWidth)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(5)
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(bookmarkButton.snp.width)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
}
