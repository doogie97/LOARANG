//
//  EngravigCVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import SnapKit

final class EngravigCVCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 13, family: .Bold)
        
        return label
    }()
    
    private func setLayout() {
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setCellContents(engraving: Engraving) {
        if engraving.title.contains("감소") {
            titleLabel.textColor = .systemRed
        }
        self.titleLabel.text = engraving.title
    }
}
