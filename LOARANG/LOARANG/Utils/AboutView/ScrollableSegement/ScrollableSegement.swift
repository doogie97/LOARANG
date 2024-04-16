//
//  ScrollableSegement.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit
protocol ScrollableSegementDelegate: AnyObject {
    func didSelected(_ segment: ScrollableSegement, index: Int)
}

final class ScrollableSegement: UIView {
    weak var delegate: ScrollableSegementDelegate?
    private var segmentTitles: [String] {
        didSet {
            self.segmentCV.reloadData()
        }
    }
    private var itemHight: CGFloat
    private var itemInset: CGFloat
    
    var segmentIndex: Int = 0
    var selectedFontColor: UIColor = .label
    var deselectedFontColor: UIColor = .systemGray
    var selectedFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold)
    var deselectedFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)
    var segmentTextAlignment: NSTextAlignment = .center
    var underLineColor: UIColor = .black {
        didSet {
            self.underLineView.backgroundColor = underLineColor
        }
    }
    var underLineHeight: CGFloat = 1
    
    init(segmentTitles: [String], itemHight: CGFloat, itemInset: CGFloat = 10.0) {
        self.segmentTitles = segmentTitles
        self.itemHight = itemHight
        self.itemInset = itemInset
        super.init(frame: .zero)
        segmentCV.delegate = self
        segmentCV.dataSource = self
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSegmentData(_ titles: [String]) {
        self.segmentTitles = titles
    }
    
    func scrollToSelecteCell(index: Int) {
        segmentCV.selectItem(at: IndexPath(item: index, section: 0), animated: true , scrollPosition: .centeredHorizontally)
        setUnderlinePosition()
    }
    
    private func setUnderlinePosition(animated: Bool = true) {
        let cell = segmentCV.cellForItem(at: IndexPath(item: self.segmentIndex, section: 0)) ?? self
        
        underLineView.snp.remakeConstraints {
            $0.leading.trailing.equalTo(cell)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(underLineHeight)
        }
        
        if animated {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.layoutIfNeeded()
            }
        } else {
            self.layoutIfNeeded()
        }
    }
    
    private lazy var underLineView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var segmentCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ScrollableSegmentCell.self, forCellWithReuseIdentifier: "\(ScrollableSegmentCell.self)")
        
        return collectionView
    }()
    
    private lazy var bottomSeparator = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    private func setLayout() {
        self.addSubview(segmentCV)
        self.addSubview(underLineView)
        self.addSubview(bottomSeparator)
        
        segmentCV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) { [weak self] in
            self?.setUnderlinePosition(animated: false)
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

extension ScrollableSegement: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.segmentTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ScrollableSegmentCell.self)", for: indexPath) as? ScrollableSegmentCell,
              let title = self.segmentTitles[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.setCellContents(cellInfo: ScrollableSegmentCell.CellInfo(isSelected: self.segmentIndex == indexPath.row,
                                                                      title: title,
                                                                      textAlignment: self.segmentTextAlignment,
                                                                      selectedFontColor: self.selectedFontColor,
                                                                      deselectedFontColor: self.deselectedFontColor,
                                                                      selectedFont: self.selectedFont,
                                                                      deselectedFont: self.deselectedFont))
        if segmentIndex == indexPath.row {
            collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ScrollableSegmentCell else {
            return
        }
        
        cell.selectCell()
        self.segmentIndex = indexPath.row
        scrollToSelecteCell(index: indexPath.row)
        delegate?.didSelected(self, index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ScrollableSegmentCell else {
            return
        }
        
        cell.deselectCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = self.segmentTitles[indexPath.row]
        let size: CGSize = .init(width: collectionView.frame.width - 10, height: itemHight)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        
        let estimatedFrame = title.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let cellWidth: CGFloat = estimatedFrame.width + (itemInset * 2)
        
        return CGSize(width: cellWidth, height: itemHight)
    }
}

