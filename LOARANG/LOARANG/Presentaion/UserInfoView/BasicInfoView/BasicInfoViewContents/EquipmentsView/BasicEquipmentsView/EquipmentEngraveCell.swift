//
//  EquipmentEngraveCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import UIKit
import SnapKit

final class EquipmentEngraveCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var firstNameLabel = makeLabel()
    private lazy var firstActivationLabel = makeLabel()
    
    private lazy var secondNameLabel = makeLabel()
    private lazy var secondActivationLabel = makeLabel()
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = .one(size: 13, family: .Bold)
        
        return label
    }
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellColor
        
        self.addSubview(firstNameLabel)
        self.addSubview(firstActivationLabel)
    
        self.addSubview(secondNameLabel)
        self.addSubview(secondActivationLabel)
        
        firstNameLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(5)
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        firstActivationLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(5)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(5)
        }

        secondNameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.centerX).inset(5)
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        secondActivationLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.centerX).inset(5)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(5)
        }
    }
    
    func setCellContents(engraves: (first: EquipedEngrave?, second: EquipedEngrave?)) {
        setLayout()
        
        firstNameLabel.text = engraves.first?.name ?? "각인1"
        firstNameLabel.textColor = engraves.first?.titleColor
        let firstActivation = engraves.first?.activation.description ?? ""
        firstActivationLabel.text = firstActivation == "" ? "장착 안됨" : "활성도 +\(firstActivation)"
        
        secondNameLabel.text = engraves.second?.name ?? "각인2"
        secondNameLabel.textColor = engraves.second?.titleColor
        let secondActivation = engraves.second?.activation.description ?? ""
        secondActivationLabel.text = secondActivation == "" ? "장착 안됨" : "활성도 +\(secondActivation)"
    }
}

