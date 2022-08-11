//
//  BasicEffectTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class BasicEffectTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = .red
    }
}
