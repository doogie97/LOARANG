//
//  EngravigsTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import SnapKit
import RxSwift

final class EngravigsTVCell: UITableViewCell {
    private var viewModel: EngravigsTVCellViewModelable?
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(engravingCollectionView)
        self.contentView.addSubview(noEngravingLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        engravingCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-5)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        noEngravingLabel.snp.makeConstraints {
            $0.centerY.equalTo(engravingCollectionView)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setCellViewModel(viewModel: EngravigsTVCellViewModelable) {
        self.viewModel = viewModel
        if viewModel.engravings.value.count == 0 {
            noEngravingLabel.isHidden = false
        }
        engravingCollectionView.dataSource = nil

        bindView()
    }
    
    private func bindView() {
        self.viewModel?.engravings.bind(to: engravingCollectionView.rx.items(cellIdentifier: "\(EngravigCVCell.self)", cellType: EngravigCVCell.self)) {index, engraving, cell in
            cell.setCellContents(engraving: engraving)
        }
        .disposed(by: disposeBag)
    }
}
