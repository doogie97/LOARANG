//
//  CharacterDetailequipmentEffectCell.swift
//  LOARANG
//
//  Created by Doogie on 4/21/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailequipmentEffectCell: UICollectionViewCell {
    private lazy var firstStackView = {
        let stackView = UIStackView(arrangedSubviews: [braceletView, secondBoxStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var braceletView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var secondBoxStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = margin(.width, 10)
        
        return stackView
    }()
    
    private func addSecondBox(title: String, valueStr: String) {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        secondBoxStackView.addArrangedSubview(view)
    }
    
    func setCellContents(characterInfo: CharacterDetailEntity) {
        let bracelet = characterInfo.jewelrys.filter { $0.equipmentType == .팔찌 }.first
        if let elixirInfo = characterInfo.elixirInfo {
            let valueStr = "\(elixirInfo.activeSpecialEffect?.name ?? "") \(elixirInfo.activeSpecialEffect?.grade ?? 0)단계"
            addSecondBox(title: "합계 \(elixirInfo.totlaLevel)", valueStr: valueStr)
        }
        
        if let transcendenceInfo = characterInfo.transcendenceInfo {
            let valueStr = "평균 \(transcendenceInfo.averageGrade)단계"
            addSecondBox(title: "합계 \(transcendenceInfo.totalCount)", valueStr: valueStr)
        }
        
        braceletView.isHidden = bracelet == nil
        secondBoxStackView.isHidden = characterInfo.elixirInfo == nil && characterInfo.transcendenceInfo == nil
        
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(firstStackView)
        
        firstStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        secondBoxStackView.subviews.forEach { $0.removeFromSuperview() }
    }
}
