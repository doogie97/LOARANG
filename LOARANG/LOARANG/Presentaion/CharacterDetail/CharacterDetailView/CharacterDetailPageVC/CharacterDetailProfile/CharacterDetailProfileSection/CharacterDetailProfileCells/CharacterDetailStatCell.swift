//
//  CharacterDetailStatCell.swift
//  LOARANG
//
//  Created by Doogie on 4/21/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharacterDetailStatCell: UICollectionViewCell {
    private lazy var basicStatTitle = statTitle(text: "기본 특성")
    
    private lazy var attTitleLabel = pretendardLabel(family: .Regular, text: "공격력",alignment: .center)
    private lazy var hpTitleLabel = pretendardLabel(family: .Regular, text: "최대 생명력", alignment: .center)
    
    private lazy var attLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var hpLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    
    private lazy var basicStatStackView = {
        let attView = equalStackView(subviews: [attTitleLabel, attLabel])
        let hpView = equalStackView(subviews: [hpTitleLabel, hpLabel])
        
        return equalStackView(subviews: [attView, hpView], axis: .vertical, spacing: 16)
    }()
    
    private lazy var battleStatTitle = statTitle(text: "전투 특성")
    
    private lazy var critTitleLabel = pretendardLabel(family: .Regular, text: "치명", alignment: .center)
    private lazy var specializationTitleLabel = pretendardLabel(family: .Regular, text: "특화", alignment: .center)
    private lazy var swiftnessTitleLabel = pretendardLabel(family: .Regular, text: "신속", alignment: .center)
    private lazy var dominationTitleLabel = pretendardLabel(family: .Regular, text: "제압", alignment: .center)
    private lazy var enduranceTitleLabel = pretendardLabel(family: .Regular, text: "인내", alignment: .center)
    private lazy var expertiseTitleLabel = pretendardLabel(family: .Regular, text: "숙련", alignment: .center)
    
    private lazy var critLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var specializationLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var swiftnessLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var dominationLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var enduranceLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var expertiseLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    
    private lazy var battleStatStackView = {
        let critView = equalStackView(subviews: [critTitleLabel, critLabel])
        let specializationView = equalStackView(subviews: [specializationTitleLabel, specializationLabel])
        let topStackView = equalStackView(subviews: [critView, specializationView], spacing: 8)
        
        let dominationView = equalStackView(subviews: [dominationTitleLabel, dominationLabel])
        let swiftnessView = equalStackView(subviews: [swiftnessTitleLabel, swiftnessLabel])
        let middleStackView = equalStackView(subviews: [swiftnessView, dominationView], spacing: 8)
        
        let enduranceView = equalStackView(subviews: [enduranceTitleLabel, enduranceLabel])
        let expertiseView = equalStackView(subviews: [expertiseTitleLabel, expertiseLabel])
        let bottomStackView = equalStackView(subviews: [enduranceView, expertiseView], spacing: 8)
        
        return equalStackView(subviews: [topStackView, middleStackView, bottomStackView], axis: .vertical, spacing: 16)
    }()
    
    private lazy var tendencyTitle = statTitle(text: "성향")
    
    private lazy var intellectTitleLabel = pretendardLabel(family: .Regular, text: "지성", alignment: .center)
    private lazy var courageTitleLabel = pretendardLabel(family: .Regular, text: "담력", alignment: .center)
    private lazy var charmTitleLabel = pretendardLabel(family: .Regular, text: "매력", alignment: .center)
    private lazy var kindnessTitleLabel = pretendardLabel(family: .Regular, text: "친절", alignment: .center)
    
    private lazy var intellectLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var courageLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var charmLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    private lazy var kindnessLabel = pretendardLabel(family: .SemiBold, alignment: .center)
    
    private lazy var tendencyStackView = {
        let intellectView = equalStackView(subviews: [intellectTitleLabel, intellectLabel])
        let courageView = equalStackView(subviews: [courageTitleLabel, courageLabel])
        let topStackView = equalStackView(subviews: [intellectView, courageView], spacing: 8)
        
        let charmView = equalStackView(subviews: [charmTitleLabel, charmLabel])
        let kindnessView = equalStackView(subviews: [kindnessTitleLabel, kindnessLabel])
        let bottomStackView = equalStackView(subviews: [charmView, kindnessView], spacing: 8)
        return equalStackView(subviews: [topStackView, bottomStackView], axis: .vertical, spacing: 16)
    }()
    
    private func equalStackView(subviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.spacing = spacing
        stackView.distribution = .fillEqually
        stackView.axis = axis
        
        return stackView
    }
    
    private func statTitle(text: String) -> UILabel {
        let label = pretendardLabel(text: text, alignment: .center)
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.backgroundColor = #colorLiteral(red: 0.1511179507, green: 0.1611060798, blue: 0.178067416, alpha: 1)
        label.layer.borderColor = UIColor.systemGray.cgColor
        label.layer.borderWidth = 0.5
        
        return label
    }
    
    func setCellContents(profileInfo: CharacterDetailEntity.Profile) {
        self.contentView.backgroundColor = .cellColor
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.contentView.layer.cornerRadius = 6
        for stat in profileInfo.stats {
            switch stat.statType {
            case .치명:
                critLabel.text = stat.value.commaNumber
            case .특화:
                specializationLabel.text = stat.value.commaNumber
            case .제압:
                dominationLabel.text = stat.value.commaNumber
            case .신속:
                swiftnessLabel.text = stat.value.commaNumber
            case .인내:
                enduranceLabel.text = stat.value.commaNumber
            case .숙련:
                expertiseLabel.text = stat.value.commaNumber
            case .최대생명력:
                hpLabel.text = stat.value.commaNumber
            case .공격력:
                attLabel.text = stat.value.commaNumber
            case .unknown:
                break
            }
            
            for tendency in profileInfo.tendencies {
                switch tendency.tendencyType {
                case .지성:
                    intellectLabel.text = tendency.value.commaNumber
                case .담력:
                    courageLabel.text = tendency.value.commaNumber
                case .매력:
                    charmLabel.text = tendency.value.commaNumber
                case .친절:
                    kindnessLabel.text = tendency.value.commaNumber
                case .unknown:
                    break
                }
            }
        }
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(basicStatTitle)
        self.contentView.addSubview(basicStatStackView)
        
        self.contentView.addSubview(battleStatTitle)
        self.contentView.addSubview(battleStatStackView)
        
        self.contentView.addSubview(tendencyTitle)
        self.contentView.addSubview(tendencyStackView)
        
        basicStatTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.width, 16))
            $0.leading.equalToSuperview().inset(margin(.width, 10))
            $0.height.equalTo(24)
            $0.width.equalTo(68)
        }
        
        basicStatStackView.snp.makeConstraints {
            $0.top.equalTo(basicStatTitle.snp.bottom).inset(margin(.width, -16))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
        }
        
        battleStatTitle.snp.makeConstraints {
            $0.top.equalTo(hpTitleLabel.snp.bottom).inset(-24)
            $0.leading.height.width.equalTo(basicStatTitle)
        }
        
        battleStatStackView.snp.makeConstraints {
            $0.top.equalTo(battleStatTitle.snp.bottom).inset(margin(.width, -16))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
        }
        
        tendencyTitle.snp.makeConstraints {
            $0.top.equalTo(battleStatStackView.snp.bottom).inset(-24)
            $0.leading.height.width.equalTo(basicStatTitle)
        }
        
        tendencyStackView.snp.makeConstraints {
            $0.top.equalTo(tendencyTitle.snp.bottom).inset(margin(.width, -16))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
        }
    }
}
