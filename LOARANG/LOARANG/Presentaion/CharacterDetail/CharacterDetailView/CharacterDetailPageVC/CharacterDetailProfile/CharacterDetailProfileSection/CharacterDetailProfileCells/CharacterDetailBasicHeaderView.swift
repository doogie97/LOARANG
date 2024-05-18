//
//  CharacterDetailBasicHeaderView.swift
//  LOARANG
//
//  Created by Doogie on 5/18/24.
//

import UIKit
import SnapKit

class EquipmentEffectHeaderView: UICollectionReusableView {
    private lazy var titleLabel = {
        let label = pretendardLabel(alignment: .center)
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        label.layer.borderColor = UIColor.systemGray.cgColor
        label.layer.borderWidth = 0.5
        
        return label
    }()
    
    func setLayout(sectionCase: CharacterDetailProfileSectionView.ProfileSectionCase?) {
        var widthInset = 0.0
        switch sectionCase {
        case .equipmentEffectView:
            titleLabel.text = "엘릭서 & 초월"
            widthInset = 6
        case .equipments:
            titleLabel.text = "장비 & 장신구"
            widthInset = 10
        default:
            return
        }
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(margin(.width, widthInset))
            $0.height.equalTo(24)
            $0.width.equalTo(95)
        }
    }
}
