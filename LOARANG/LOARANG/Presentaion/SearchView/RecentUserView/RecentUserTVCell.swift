//
//  RecentUserTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import UIKit
import SnapKit

final class RecentUserTVCell: UITableViewCell {
    private weak var viewModel: SearchViewModelable?
    private var index: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.borderWidth = 0.1
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 16, family: .Bold)
        
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .systemGray
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 18, weight: .bold, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchDeleteButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchDeleteButton() {
        guard let index = self.index else {
            return
        }
        viewModel?.touchDeleteRecentUserButton(index)
    }
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchBookmarkButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func touchBookmarkButton(_ sender: UIButton) {
        guard let index = self.index else {
            return
        }
        let isNowBookmark = sender.tag == 0
        viewModel?.touchBookmarkButton(index: index, isNowBookmark: isNowBookmark)
        bookmarkButton.setBookmarkButtonColor(!isNowBookmark)
    }
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.selectionStyle = .none
        
        self.contentView.addSubview(characterImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(deleteButton)
        self.contentView.addSubview(bookmarkButton)
        
        characterImageView.snp.makeConstraints {
            let height = UIScreen.main.bounds.width * 0.1
            $0.height.equalTo(height)
            $0.width.equalTo(height)
            $0.top.leading.equalToSuperview().inset(10)
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
            
            characterImageView.layer.cornerRadius = height / 2
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(characterImageView.snp.trailing).offset(16)
            $0.top.bottom.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(deleteButton.snp.leading).inset(-16)
        }
    }
    
    func setCellContents(recentUser: RecentUserEntity,
                         viewModel: SearchViewModelable?,
                         index: Int) {
        self.viewModel = viewModel
        self.index = index
        if recentUser.imageUrl.replacingOccurrences(of: " ", with: "").isEmpty {
            self.characterImageView.image = UIImage(named: "unknownCharacterImg.png")
        } else {
            self.characterImageView.setImage(recentUser.imageUrl) { [weak self] in
                self?.characterImageView.image = $0.cropImage(characterClass: recentUser.characterClass)
            }
        }
        self.nameLabel.text = recentUser.name
        self.bookmarkButton.setBookmarkButtonColor(recentUser.name.isBookmark)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.index = nil
    }
}
