//
//  BasicEquipmentView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import SnapKit

final class BasicEquipmentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [equipmentTableView, accessoryTableView])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private(set) lazy var equipmentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cellColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(EquipmentCell.self)
        tableView.register(EquipmentEngraveCell.self)
        return tableView
    }()
    
    private(set) lazy var accessoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cellColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(EquipmentCell.self)
        
        return tableView
    }()
    
    private lazy var gemView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var gemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "보석"
        label.font = .one(size: 15, family: .Bold)
        
        return label
    }()
    
    private(set) lazy var gemCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellColor
        collectionView.register(GemCell.self, forCellWithReuseIdentifier: "\(GemCell.self)")
        
        collectionView.isScrollEnabled = false

        return collectionView
    }()
    
    private lazy var noGemLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 13, family: .Bold)
        label.textAlignment = .center
        label.text = "장착된 보석이 없습니다"
        
        return label
    }()
    
    //MARK: - GemDeteail
    private(set) lazy var gemDetailView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 0.5
        
        view.addSubview(gemNameLabel)
        view.addSubview(gemEffectLabel)
        view.addSubview(xMarkLabel)
        
        gemNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }

        gemEffectLabel.snp.makeConstraints {
            $0.top.equalTo(gemNameLabel.snp.bottom).inset(-5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        xMarkLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
        }
        
        return view
    }()
    
    private lazy var gemNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var gemEffectLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var xMarkLabel: UILabel = {
        let label = UILabel()
        label.text = "×"
        label.font = .one(size: 15, family: .Bold)
        
        return label
    }()
    
    func setLayout(isNoGem: Bool) {
        self.addSubview(mainStackView)
        self.addSubview(gemView)
        gemView.addSubview(gemTitleLabel)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(gemView.snp.top)
        }
        
        gemView.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(5)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        gemTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        if isNoGem {
            gemView.addSubview(noGemLabel)
            
            noGemLabel.snp.makeConstraints {
                $0.top.equalTo(gemTitleLabel.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(8)
                $0.top.equalTo(gemView.snp.centerY)
            }
        } else {
            gemView.addSubview(gemCollectionView)
            self.addSubview(gemDetailView)
            
            gemCollectionView.snp.makeConstraints {
                $0.top.equalTo(gemTitleLabel.snp.bottom)
                $0.leading.bottom.trailing.equalToSuperview().inset(5)
            }
            
            gemDetailView.snp.makeConstraints {
                $0.trailing.leading.equalToSuperview().inset(5)
                $0.bottom.equalTo(gemTitleLabel.snp.bottom)
                $0.height.greaterThanOrEqualTo(15)
            }
        }
    }
    
    func showGemDetail(gem: Gem) {
        gemDetailView.isHidden = false
        
        gemNameLabel.attributedText = gem.name.htmlToAttributedString(fontSize: 4, alignment: .LEFT)
        gemEffectLabel.attributedText = gem.effect.htmlToAttributedString(fontSize: 1, alignment: .LEFT)
    }
}
