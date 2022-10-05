//
//  RecentUserTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import SnapKit
import RxSwift

final class RecentUserTVCell: UITableViewCell {
    private var viewModel: RecentUserCellViewModelable?
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
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        
        return button
    }()
    
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
                owner.viewModel?.touchDeleteButton()
            })
            .disposed(by: disposeBag)
    }
    
    func setCellContents(viewModel:RecentUserCellViewModelable?) {
        self.viewModel = viewModel
        
        guard let user = viewModel?.userInfo else {
            return
        }
        
        self.userImageView.image = user.image.cropImage(class: user.class)
        self.nameLabel.text = user.name
    }
}
