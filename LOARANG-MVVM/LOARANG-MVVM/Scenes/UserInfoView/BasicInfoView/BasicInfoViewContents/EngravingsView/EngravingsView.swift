//
//  EngravingsView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import SnapKit

final class EngravingsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: PaddingLabel = {
        let label = PaddingLabel(top: 5, bottom: 5, left: 3, right: 3)
        label.font = .one(size: 18, family: .Bold)
        label.text = "각인 효과"
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.1659600362, green: 0.1790002988, blue: 0.1983416486, alpha: 1)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }()
    
    private(set) lazy var engravingCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.075))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 3, trailing: 3)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellColor
        collectionView.layer.cornerRadius = 10
        collectionView.register(EngravigCVCell.self, forCellWithReuseIdentifier: "\(EngravigCVCell.self)")
        
        collectionView.isScrollEnabled = false

        return collectionView
    }()
    
    private lazy var noEngravingLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 13, family: .Bold)
        label.textAlignment = .center
        label.text = "활성화된 각인이 없습니다"
        
        return label
    }()
    
    func setLayout(isNoEngraving: Bool) {
        self.backgroundColor = .cellColor
        self.layer.cornerRadius = 10
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        if isNoEngraving {
            self.addSubview(noEngravingLabel)
            
            noEngravingLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
                $0.leading.trailing.equalToSuperview().inset(8)
                $0.bottom.equalToSuperview().inset(16)
            }
        } else {
            self.addSubview(engravingCollectionView)
            
            engravingCollectionView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
