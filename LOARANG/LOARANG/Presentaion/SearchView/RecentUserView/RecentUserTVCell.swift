//
//  RecentUserTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import SnapKit
import RxSwift

final class RecentUserTVCell: UITableViewCell {
    private weak var viewModel: SearchViewModelable?
    private var index: Int?
    
    private var cellViewModel: RecentUserCellViewModelable?
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var userImageView: UIImageView = {
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
        
        return button
    }()
    
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
        
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(deleteButton)
        self.contentView.addSubview(bookmarkButton)
        
        userImageView.snp.makeConstraints {
            let height = UIScreen.main.bounds.width * 0.1
            $0.height.equalTo(height)
            $0.width.equalTo(height)
            $0.top.leading.equalToSuperview().inset(10)
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
            
            userImageView.layer.cornerRadius = height / 2
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(16)
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
        
        bind()
    }
    
    private func bind() {
        deleteButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.cellViewModel?.touchDeleteButton()
            })
            .disposed(by: disposeBag)
    }
    
    func setCellContents(cellViewModel:RecentUserCellViewModelable?,
                         viewModel: SearchViewModelable?,
                         index: Int) {
        self.cellViewModel = cellViewModel
        self.viewModel = viewModel
        self.index = index
        
        guard let user = cellViewModel?.userInfo else {
            return
        }
        
        self.userImageView.image = user.image.cropImage(class: user.class)
        self.nameLabel.text = user.name
        self.bookmarkButton.setBookmarkButtonColor(cellViewModel?.isBookmarkUser ?? false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.index = nil
    }
}
