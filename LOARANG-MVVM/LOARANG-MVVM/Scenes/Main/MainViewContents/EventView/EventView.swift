//
//  EventView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import SnapKit

final class EventView: UIView {
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
    
    private lazy var eventTitle: UILabel = {
        let label = UILabel()
        label.text = "이벤트"
        label.font = UIFont.BlackHanSans(size: 20)
        label.textColor = .buttonColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private(set) lazy var moreEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = UIFont.one(size: 13, family: .Bold)
        
        return button
    }()
    
    private(set) lazy var eventCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellBackgroundColor
        collectionView.register(EventCVCell.self, forCellWithReuseIdentifier: "\(EventCVCell.self)")
        
        collectionView.isScrollEnabled = false

        return collectionView
    }()
    
    private func setLayout() {
        self.backgroundColor = .tableViewColor
        self.addSubview(backView)
        
        backView.addSubview(eventTitle)
        backView.addSubview(moreEventButton)
        backView.addSubview(eventCollectionView)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        eventTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        moreEventButton.snp.makeConstraints {
            $0.centerY.equalTo(eventTitle)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        eventCollectionView.snp.makeConstraints {
            $0.top.equalTo(eventTitle.snp.bottom).inset(-4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
