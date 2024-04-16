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
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func selectCell() {
        self.cellInfo?.isSelected = true
    }
    
    func deselectCell() {
        self.cellInfo?.isSelected = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellInfo = nil
        titleLabel.text = nil
        titleLabel.font = nil
        titleLabel.textColor = nil
    }
}

