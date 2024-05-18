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
    private lazy var infoStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = margin(.width, 10)
        
        return stackView
    }()
    
    private func addStackview(title: String, topText: String, bottomText: String) {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        
        let titleLabel = pretendardLabel(text: title)
        let topLabel = pretendardLabel(size: 12, family: .SemiBold, color: .systemGray, text: topText)
        let bottomLabel = pretendardLabel(size: 12, family: .SemiBold, text: bottomText)
        
        view.addSubview(titleLabel)
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(margin(.width, 8))
        }
        
        topLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).inset(margin(.width, -12))
        }
        
        bottomLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(margin(.width, 12))
        }

        infoStackView.addArrangedSubview(view)
    }
    
    func setCellContents(characterInfo: CharacterDetailEntity) {
        if let elixirInfo = characterInfo.elixirInfo {
            let bottomText = "\(elixirInfo.activeSpecialEffect?.name ?? "") \(elixirInfo.activeSpecialEffect?.grade ?? 0)단계"
            addStackview(title: "엘릭서", topText: "합계 \(elixirInfo.totlaLevel)", bottomText: bottomText)
        }
        
        if let transcendenceInfo = characterInfo.transcendenceInfo {
            let bottomText = "평균 \(transcendenceInfo.averageGrade)단계"
            addStackview(title: "초월", topText: "합계 \(transcendenceInfo.totalCount)", bottomText: bottomText)
        }
        
        infoStackView.isHidden = characterInfo.elixirInfo == nil && characterInfo.transcendenceInfo == nil
        noEffectLabel.isHidden = characterInfo.elixirInfo != nil && characterInfo.transcendenceInfo != nil
        setLayout()
    }
    private lazy var noEffectLabel = pretendardLabel(size: 15, family: .SemiBold, text: "적용된 엘릭서 & 초월 효과가 없습니다.", alignment: .center)
    
    private func setLayout() {
        self.contentView.addSubview(infoStackView)
        self.contentView.addSubview(noEffectLabel)
        
        infoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        noEffectLabel.backgroundColor = .cellColor
        noEffectLabel.layer.cornerRadius = 6
        noEffectLabel.clipsToBounds = true
        noEffectLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        infoStackView.subviews.forEach { $0.removeFromSuperview() }
    }
}
