//
//  AvatarView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import SnapKit

final class AvatarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftTableView, rightTableView])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private(set) lazy var leftTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cellColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(EquipmentCell.self)
        tableView.register(EquipmentEngraveCell.self)
        return tableView
    }()
    
    private(set) lazy var rightTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cellColor
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(EquipmentCell.self)
        
        return tableView
    }()
    
    private lazy var specialEquipmentsBackView: UIView = {
        let view = UIView()
        view.addSubview(specialEquipmentTitleLabel)
        view.addSubview(specialEquipmentCollectionView)
        
        specialEquipmentTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        specialEquipmentCollectionView.snp.makeConstraints {
            $0.top.equalTo(specialEquipmentTitleLabel.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview().inset(5)
        }
        
        return view
    }()
    
    private lazy var specialEquipmentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "특수 장비"
        label.font = .one(size: 15, family: .Bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    private(set) lazy var specialEquipmentCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellColor
        collectionView.register(SpecialEquipmentCell.self, forCellWithReuseIdentifier: "\(SpecialEquipmentCell.self)")
        
        collectionView.isScrollEnabled = false

        return collectionView
    }()
    
    private func setLayout() {
        self.addSubview(mainStackView)
        self.addSubview(specialEquipmentsBackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(5)
            $0.bottom.equalTo(specialEquipmentsBackView.snp.top)
        }
        
        specialEquipmentsBackView.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(5)
            $0.trailing.leading.bottom.equalToSuperview()
        }

    }
}
