//
//  CardView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/04.
//

import SnapKit

final class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private lazy var titleLabel: PaddingLabel = {
        let label = PaddingLabel(top: 5, bottom: 5, left: 3, right: 3)
        label.font = .one(size: 18, family: .Bold)
        label.text = "장착 카드"
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.1659600362, green: 0.1790002988, blue: 0.1983416486, alpha: 1)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }()
    
    private(set) lazy var cardCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 1.5, bottom: 3, trailing: 1.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellColor
        collectionView.layer.cornerRadius = 10
        collectionView.register(CardCVCell.self, forCellWithReuseIdentifier: "\(CardCVCell.self)")
        
        collectionView.isScrollEnabled = false

        return collectionView
    }()
    
    private lazy var effectTitleLabel: PaddingLabel = {
        let label = PaddingLabel(top: 5, bottom: 5, left: 3, right: 3)
        label.font = .one(size: 18, family: .Bold)
        label.text = "카드 효과"
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.1659600362, green: 0.1790002988, blue: 0.1983416486, alpha: 1)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }()
    
    private(set) lazy var cardSetEffectTableView: DynamicHeightTableView = {
        let tableView = DynamicHeightTableView()
        tableView.backgroundColor = .cellColor
        tableView.separatorStyle = .none
        tableView.register(CardSetEffectTVCell.self)
        
        return tableView
    }()
    
    private lazy var noCardLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 13, family: .Bold)
        label.textAlignment = .center
        label.text = "장착된 카드가 없습니다"
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(isNoCard: Bool) {
        self.backgroundColor = .cellColor
        self.layer.cornerRadius = 10
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        if isNoCard {
            self.addSubview(noCardLabel)
            
            noCardLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).inset(-16)
                $0.leading.trailing.equalToSuperview().inset(8)
                $0.bottom.equalToSuperview().inset(16)
            }
        } else {
            self.addSubview(cardCollectionView)
            self.addSubview(effectTitleLabel)
            self.addSubview(cardSetEffectTableView)
            
            cardCollectionView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).inset(-8)
                $0.leading.trailing.equalToSuperview().inset(5)
                $0.height.equalTo(UIScreen.main.bounds.width * 0.94)
            }
            
            effectTitleLabel.snp.makeConstraints {
                $0.top.equalTo(cardCollectionView.snp.bottom).inset(-8)
                $0.leading.trailing.equalToSuperview().inset(8)
            }
            
            cardSetEffectTableView.snp.makeConstraints {
                $0.top.equalTo(effectTitleLabel.snp.bottom).inset(-5)
                $0.leading.trailing.equalToSuperview().inset(8)
                $0.bottom.equalToSuperview().inset(8)
            }
        }
    }
}
