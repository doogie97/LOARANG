//
//  SubOptionCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import SnapKit

final class SubOptionCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var optionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private func setLayout() {
        self.backgroundColor = .clear
        self.contentView.addSubview(optionTitleLabel)
        
        optionTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    func setCellContents(optionTitle: String) {
        optionTitleLabel.text = optionTitle
    }
}
