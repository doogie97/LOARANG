//
//  MarketItemCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/15.
//

import SnapKit

final class MarketItemCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private func setLayout() {
        self.contentView.addSubview(itemImageView)
        
        itemImageView.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.edges.equalToSuperview()
        }
    }
}
