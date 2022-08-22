//
//  EquipmentEngraveCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import SnapKit
final class EquipmentEngraveCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
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
        label.font = .one(size: 12, family: .Bold)
        
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
        firstNameLabel.text = "진실된 용맹"
        
        firstActivationLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(5)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(5)
        }
        
        firstActivationLabel.text = "+12"

        secondNameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.centerX).inset(5)
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
        }
        secondNameLabel.text = "진실된 용맹"
        
        secondActivationLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.centerX).inset(5)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(5)
        }
        
        secondActivationLabel.text = "+12"
    }
    
    func setCellContents(engraves: (first: EquipedEngrave?, second: EquipedEngrave?)) {
        firstNameLabel.text = engraves.first?.name
        firstActivationLabel.text = engraves.first?.activation.htmlToString
        
        secondNameLabel.text = engraves.second?.name
        secondActivationLabel.text = engraves.second?.activation.htmlToString
    }
}

