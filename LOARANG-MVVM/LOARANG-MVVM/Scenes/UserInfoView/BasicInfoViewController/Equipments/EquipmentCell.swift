//
//  EquipmentCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/19.
//

import SnapKit

final class EquipmentCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var laber = UILabel()
    
    func setLayout(equipmentPart: EquipmentPartable?) {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        

        laber.text = equipmentPart?.quality?.description
        self.contentView.addSubview(laber)
        
        laber.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
}
