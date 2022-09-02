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
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 18, family: .Bold)
        label.text = "각인 효과"
        
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
        label.isHidden = true
        
        return label
    }()
    
    private func setLayout() {
        self.backgroundColor = .cellBackgroundColor
        
        self.addSubview(contentsView)
        
        contentsView.addSubview(titleLabel)
        contentsView.addSubview(engravingCollectionView)
        contentsView.addSubview(noEngravingLabel)
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        engravingCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        noEngravingLabel.snp.makeConstraints {
            $0.top.equalTo(engravingCollectionView.snp.top)
            $0.centerX.equalToSuperview()
        }
    }
    
    func showNoEngravingLabel() {
        noEngravingLabel.isHidden = false
    }
}
