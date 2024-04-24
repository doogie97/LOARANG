//
//  CharacterDetailCardSectionBG.swift
//  LOARANG
//
//  Created by Doogie on 4/23/24.
//

import UIKit

final class CharacterDetailCardSectionBG: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel = {
        let label = pretendardLabel(text: "카드", alignment: .center)
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        label.layer.borderColor = UIColor.systemGray.cgColor
        label.layer.borderWidth = 0.5
        
        return label
    }()
    
    private func setLayout() {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 6
        
        self.addSubview(view)
        view.addSubview(titleLabel)
        
        view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 8))
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.width, 16))
            $0.leading.equalToSuperview().inset(margin(.width, 10))
            $0.height.equalTo(24)
            $0.width.equalTo(68)
        }
    }
}

