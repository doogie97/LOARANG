//
//  BookmarkCVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import SnapKit
import RxSwift

final class BookmarkCVCell: UICollectionViewCell {
    private var viewModel: BookmarkCVCellViewModelable?
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, imageStackView, nameLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let empty1 = UILabel()
        let stackView = UIStackView(arrangedSubviews: [empty1, bookmarkButton])
        stackView.alignment = .bottom
        
        return stackView
    }()
    
    private(set) lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        
        return button
    }()
    
    private lazy var imageStackView: UIStackView = {
        let empty1 = UILabel()
        let empty2 = UILabel()
        let stackView = UIStackView(arrangedSubviews: [empty1, userImageView, empty2])
        
        empty1.snp.makeConstraints {
            $0.width.equalTo(empty2)
        }
        
        return stackView
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIScreen.main.bounds.width / 10
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 15, family: .Bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private func setLayout() {
        self.backgroundColor = .cellColor
        self.layer.cornerRadius = 10
        self.contentView.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        topStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.2)
        }
        
        userImageView.snp.makeConstraints {
            $0.width.equalTo(userImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
        
        bind()
    }
    
    private func bind() {
        bookmarkButton.rx.tap.bind(onNext: {
            self.viewModel?.touchStarButton(self.nameLabel.text ?? "")
        })
        .disposed(by: disposeBag)
    }
    
    func setCell(_ info: BookmarkUser, viewModel: BookmarkCVCellViewModelable?) {
        self.viewModel = viewModel
        nameLabel.text = info.name
        userImageView.image = info.image.cropImage(class: info.class)
    }
}
