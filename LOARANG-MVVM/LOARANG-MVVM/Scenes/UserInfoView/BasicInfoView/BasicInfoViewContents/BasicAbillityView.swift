//
//  BasicAbillityView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import SnapKit

final class BasicAbillityView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var topStackView: UIStackView = {
        let leftStackView = equllyStackView(axis: .vertical,
                                                    arrangedSubviews: [attackTitleLabel, attackLabel])
        let rightStackView = equllyStackView(axis: .vertical,
                                                     arrangedSubviews: [vitalityTitleLabel, vitalityLabel])
        
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let critStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [critTitleLabel, critLabel])
        let dominationStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [dominationTitleLabel, dominationLabel])
        let enduranceStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [enduranceTitleLabel, enduranceLabel])
        
        let leftStackView = equllyStackView(axis: .vertical, arrangedSubviews: [critStackView, dominationStackView, enduranceStackView], spacing: 10)
        
        let specializationStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [specializationTitleLabel, specializationLabel])
        let swiftnessStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [swiftnessTitleLabel, swiftnessLabel])
        let expertiseStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [expertiseTitleLabel, expertiseLabel])
        
        let rightStackView = equllyStackView(axis: .vertical, arrangedSubviews: [specializationStackView, swiftnessStackView, expertiseStackView], spacing: 10)
        
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private func equllyStackView(axis: NSLayoutConstraint.Axis, arrangedSubviews: [UIView], spacing: CGFloat = 0) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        
        return stackView
    }
    
    private let largeFontSize = 18
    private let smallFontSize = 15
    private let statColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    
    private lazy var attackTitleLabel = makeLable(size: largeFontSize, text: "공격력")
    private lazy var vitalityTitleLabel = makeLable(size: largeFontSize, text: "생명력")
    private lazy var critTitleLabel = makeLable(size: smallFontSize, text: "치명")
    private lazy var specializationTitleLabel = makeLable(size: smallFontSize, text: "특화")
    private lazy var dominationTitleLabel = makeLable(size: smallFontSize, text: "제압")
    private lazy var swiftnessTitleLabel = makeLable(size: smallFontSize, text: "신속")
    private lazy var enduranceTitleLabel = makeLable(size: smallFontSize, text: "인내")
    private lazy var expertiseTitleLabel = makeLable(size: smallFontSize, text: "숙련")
    
    private lazy var attackLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var vitalityLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var critLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var specializationLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var dominationLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var swiftnessLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var enduranceLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var expertiseLabel = makeLable(size: smallFontSize, color: statColor)
    
    private func makeLable(size: Int, color: UIColor = .label, text: String = "10000") -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: size, family: .Bold)
        label.textColor = color
        label.text = text
        
        return label
    }
    
    private func setLayout() {
        self.backgroundColor = .cellBackgroundColor
        
        self.addSubview(contentsView)
        
        contentsView.addSubview(topStackView)
        contentsView.addSubview(bottomStackView)
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setViewContents(_ ability: BasicAbility) {
        attackLabel.text = ability.attack
        vitalityLabel.text = ability.vitality
        critLabel.text = ability.crit
        specializationLabel.text = ability.specialization
        dominationLabel.text = ability.domination
        swiftnessLabel.text = ability.swiftness
        enduranceLabel.text = ability.endurance
        expertiseLabel.text = ability.expertise
    }
}
