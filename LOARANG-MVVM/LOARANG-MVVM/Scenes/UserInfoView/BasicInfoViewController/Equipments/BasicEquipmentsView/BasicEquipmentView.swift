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
        setLayout()
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
        label.font = .one(size: 18, family: .Bold)
        
        return label
    }()
    
    private lazy var gemCollectionView: UICollectionView = { //임시 레이아웃
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.register(BookmarkCVCell.self, forCellWithReuseIdentifier: "\(BookmarkCVCell.self)")

        return collectionView
    }()
    
    private func setLayout() {
        self.addSubview(mainStackView)
        self.addSubview(gemView)
        gemView.addSubview(gemTitleLabel)
        gemView.addSubview(gemCollectionView)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(5)
            $0.bottom.equalTo(gemView.snp.top)
        }
        
        gemView.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(5)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        gemTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        gemCollectionView.snp.makeConstraints {
            $0.top.equalTo(gemTitleLabel.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview().inset(5)
        }
    }
}
