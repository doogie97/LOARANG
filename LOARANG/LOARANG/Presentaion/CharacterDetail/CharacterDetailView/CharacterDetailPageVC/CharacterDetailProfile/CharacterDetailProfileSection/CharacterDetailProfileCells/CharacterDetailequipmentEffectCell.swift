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
        
        let titleLabel = pretendardLabel(text: "팔찌")
        view.addSubview(titleLabel)
        view.addSubview(braceletImageView)
        view.addSubview(braceletTopLabel)
        view.addSubview(braceletbottomLabel)
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(margin(.width, 8))
        }
        
        braceletImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(margin(.width, -8))
            $0.bottom.leading.equalToSuperview().inset(margin(.width, 8))
            $0.width.equalTo(braceletImageView.snp.height)
        }
        
        braceletTopLabel.snp.makeConstraints {
            $0.bottom.equalTo(braceletbottomLabel.snp.top).inset(margin(.width, -8))
            $0.leading.equalTo(braceletImageView.snp.trailing).inset(margin(.width, -8))
            $0.trailing.equalToSuperview().inset(margin(.width, -8))
        }
        
        braceletbottomLabel.snp.makeConstraints {
            $0.bottom.equalTo(braceletImageView).inset(4)
            $0.leading.equalTo(braceletImageView.snp.trailing).inset(margin(.width, -8))
            $0.trailing.equalToSuperview().inset(margin(.width, -8))
        }
        
        return view
    }()
    
    private lazy var braceletImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    private lazy var braceletTopLabel = pretendardLabel(size: 12, family: .SemiBold, color: .systemGray, lineCount: 2)
    private lazy var braceletbottomLabel = pretendardLabel(size: 12, family: .SemiBold)
    
    private lazy var secondBoxStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = margin(.width, 10)
        
        return stackView
    }()
    
    private func addSecondBox(title: String, topText: String, bottomText: String) {
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

        secondBoxStackView.addArrangedSubview(view)
    }
    
    func setCellContents(characterInfo: CharacterDetailEntity) {
        if let bracelet = characterInfo.jewelrys.filter({ $0.equipmentType == .팔찌 }).first {
            braceletImageView.setImage(bracelet.imageUrl)
            braceletImageView.backgroundColor = bracelet.grade.backgroundColor
            braceletTopLabel.text = bracelet.basicEffect.joined(separator: " ")
            braceletbottomLabel.text = bracelet.additionalEffect.joined(separator: " ")
        }
        if let elixirInfo = characterInfo.elixirInfo {
            let bottomText = "\(elixirInfo.activeSpecialEffect?.name ?? "") \(elixirInfo.activeSpecialEffect?.grade ?? 0)단계"
            addSecondBox(title: "엘릭서", topText: "합계 \(elixirInfo.totlaLevel)", bottomText: bottomText)
        }
        
        if let transcendenceInfo = characterInfo.transcendenceInfo {
            let bottomText = "평균 \(transcendenceInfo.averageGrade)단계"
            addSecondBox(title: "초월", topText: "합계 \(transcendenceInfo.totalCount)", bottomText: bottomText)
        }
        
        braceletView.isHidden = characterInfo.jewelrys.filter({ $0.equipmentType == .팔찌 }).first == nil
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
