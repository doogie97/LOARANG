//
//  EquipmentsTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class EquipmentsTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentControll, pageView])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .cellColor
        
        segmentControll.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        return stackView
    }()
    
    let segmentControll = SegmentControllerView(frame: .zero,
                                                segmentTitles: ["장비", "아바타"])
    
    private lazy var pageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        self.segmentControll.backgroundColor = .tableViewColor
        self.segmentControll.layer.cornerRadius = 10
        self.segmentControll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.contentView.addSubview(mainStackView)

        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
    }
}
