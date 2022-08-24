//
//  SkillTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

import SnapKit

final class SkillTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .systemBlue
    }
}
