//
//  CategoryOptionCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/31.
//

import SnapKit

final class CategoryOptionCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var codeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private func setLayout() {
        self.contentView.addSubview(codeNameLabel)
        
        codeNameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    func setCellContents(_ codeName: String) {
        self.backgroundColor = .clear
        codeNameLabel.text = codeName
    }
}
