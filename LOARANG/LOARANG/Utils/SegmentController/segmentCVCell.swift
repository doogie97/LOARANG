//
//  segmentCVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/05.
//

import SnapKit

final class SegmentCVCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()


    private func setLayout() {
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setCellContents(title: String, textAlignment: NSTextAlignment) {
        titleLabel.text = title
        titleLabel.textAlignment = textAlignment
    }
    
    func selectedCell(color: UIColor, font: UIFont) {
        titleLabel.font = font
        titleLabel.textColor = color
    }
    
    func deselectedCell(color: UIColor, font: UIFont) {
        titleLabel.font = font
        titleLabel.textColor = color
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        titleLabel.font = nil
        titleLabel.textColor = nil
    }
}
