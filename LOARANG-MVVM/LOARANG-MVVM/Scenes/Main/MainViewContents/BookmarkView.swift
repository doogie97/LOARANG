//
//  BookmarkView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import SnapKit

final class BookmarkView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        
        return view
    }()
    
    private lazy var bookmartTitle: UILabel = {
        let label = UILabel()
        label.text = "즐겨찾기"
        label.font = UIFont.BlackHanSans(size: 20)
        label.textColor = .buttonColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private lazy var bookmarkCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 15, family: .Bold)
        label.textColor = .buttonColor
        
        return label
    }()
    
    private(set) lazy var bookMarkCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellBackgroundColor
        collectionView.register(BookmarkCVCell.self, forCellWithReuseIdentifier: "\(BookmarkCVCell.self)")
        
        collectionView.isScrollEnabled = false

        return collectionView
    }()

    private func setLayout() {
        self.backgroundColor = .tableViewColor
        self.addSubview(backView)
        
        backView.addSubview(bookmartTitle)
        backView.addSubview(bookmarkCountLabel)
        backView.addSubview(bookMarkCollectionView)
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        bookmartTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        bookmarkCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(bookmartTitle)
            $0.leading.equalTo(bookmartTitle.snp.trailing).inset(-2)
        }
        
        bookMarkCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookmartTitle.snp.bottom).inset(-4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        }
    }
}
