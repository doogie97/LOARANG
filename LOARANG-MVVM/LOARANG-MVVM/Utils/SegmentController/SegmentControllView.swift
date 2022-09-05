//
//  SegmentControllView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/05.
//

import SnapKit

final class CustomSegmentControl: UIView {
    private let segmentTitles: [String]
    var underLineColor: UIColor? = .label {
        didSet {
            underLineView.backgroundColor = underLineColor
        }
    }
    
    var backColor: UIColor? = .clear {
        didSet {
            backView.backgroundColor = backColor
        }
    }
    
    var selectedFontColor: UIColor = .label
    var deselectedFontColor: UIColor = .systemGray
    var selectedFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold)
    var deselectedFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)
    var segmentTextAlignment: NSTextAlignment = .center
    
    init(segmentTitles: [String]) {
        self.segmentTitles = segmentTitles
        
        super.init(frame: .zero)
        setLayout()
        segmentCollectionView.dataSource = self
        segmentCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = backColor
        
        return view
    }()
    
    private(set) lazy var segmentCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: segmentTitles.count)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(SegmentCVCell.self, forCellWithReuseIdentifier: "\(SegmentCVCell.self)")
        
        collectionView.isScrollEnabled = false

        return collectionView
    }()
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = underLineColor
        
        return view
    }()
    
    private func setLayout() {
        self.addSubview(backView)
        self.addSubview(segmentCollectionView)
        self.addSubview(underLineView)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(3)
            $0.width.equalTo(segmentCollectionView.snp.width).dividedBy(segmentTitles.count)
            $0.leading.equalTo(segmentCollectionView)
        }
        
        segmentCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(segmentCollectionView.snp.bottom)
            $0.height.equalTo(2)
            
            $0.leading.equalTo(segmentCollectionView)
            
            $0.width.equalTo(segmentCollectionView.snp.width).dividedBy(segmentTitles.count)
        }
    }
}

extension CustomSegmentControl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.segmentTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SegmentCVCell.self)", for: indexPath) as? SegmentCVCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
            cell.selectedCell(color: selectedFontColor, font: selectedFont)
        } else {
            cell.deselectedCell(color: deselectedFontColor, font: deselectedFont)
        }
        
        cell.setCellContents(title: segmentTitles[indexPath.row], textAlignment: segmentTextAlignment)
        return cell
    }
}

extension CustomSegmentControl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        guard let cell = collectionView.cellForItem(at: indexPath) as? SegmentCVCell else {
            return
        }
        cell.selectedCell(color: selectedFontColor, font: selectedFont)
        changeUnderLinePosition(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SegmentCVCell else {
            return
        }
        cell.deselectedCell(color: deselectedFontColor, font: deselectedFont)
    }
    
    private func changeUnderLinePosition(index: Int) {
        let segmentIndex = CGFloat(index) //여기에 콜렉션 뷰 row전달하기
        let segmentWidth = segmentCollectionView.frame.width / CGFloat(segmentTitles.count)
        let leadingDistance = segmentWidth * segmentIndex

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else {
                return
            }

            self.underLineView.snp.updateConstraints {
                $0.leading.equalTo(self.segmentCollectionView).inset(leadingDistance)
            }
            
            self.backView.snp.updateConstraints {
                $0.leading.equalTo(self.segmentCollectionView).inset(leadingDistance)
            }
            
            self.layoutIfNeeded()
        })
    }
}
