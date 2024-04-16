//
//  ScrollableSegmentCell.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class ScrollableSegmentCell: UICollectionViewCell {
    private var cellInfo: CellInfo? {
        didSet {
            guard let cellInfo = cellInfo else{
                return
            }
            
            if cellInfo.isSelected {
                titleLabel.textColor = cellInfo.selectedFontColor
                titleLabel.font = cellInfo.selectedFont
            } else {
                titleLabel.textColor = cellInfo.deselectedFontColor
                titleLabel.font = cellInfo.deselectedFont
            }
            
            underLine.isHidden = !cellInfo.isSelected
        }
    }
    
    struct CellInfo {
        var isSelected: Bool
        let title: String
        let textAlignment: NSTextAlignment
        let selectedFontColor: UIColor
        let deselectedFontColor: UIColor
        let selectedFont: UIFont
        let deselectedFont: UIFont
        let underLineColor: UIColor
        let underLineHeight: CGFloat
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = cellInfo?.underLineColor ?? .black
        view.isHidden = true
        
        return view
    }()
    
    func setCellContents(cellInfo: CellInfo) {
        titleLabel.text = cellInfo.title
        titleLabel.textAlignment = cellInfo.textAlignment
        titleLabel.textColor = cellInfo.deselectedFontColor
        titleLabel.font = cellInfo.deselectedFont
        self.cellInfo = cellInfo
        
        if self.contentView.subviews.isEmpty {
            setLayout()
        }
    }
    
    private func setLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(underLine)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(cellInfo?.underLineHeight ?? 1)
        }
    }
    
    func showUnderLine(_ direction: Direction) {
        self.cellInfo?.isSelected = true
    }
    
    func hideUnderLine(_ direction: Direction) {
        self.cellInfo?.isSelected = false
    }
    
    enum Direction {
        case right
        case left
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellInfo = nil
        titleLabel.text = nil
        titleLabel.font = nil
        titleLabel.textColor = nil
    }
}

