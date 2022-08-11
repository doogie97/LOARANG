//
//  BasicEffectTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import SnapKit

final class BasicEffectTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let topEmptyView = UIView()
        let bottomEmptyView = UIView()
        
     
        
        let stackView = UIStackView(arrangedSubviews: [topEmptyView, topStackView, bottomStackView, bottomEmptyView])
        stackView.axis = .vertical
        stackView.backgroundColor = .cellColor
        stackView.layer.cornerRadius = 10
        
        topEmptyView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        
        bottomEmptyView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        
        return stackView
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
        
        let leftStackView = equllyStackView(axis: .vertical, arrangedSubviews: [critStackView, dominationStackView, enduranceStackView])
        
        let specializationStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [specializationTitleLabel, specializationLabel])
        let swiftnessStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [swiftnessTitleLabel, swiftnessLabel])
        let expertiseStackView = equllyStackView(axis: .horizontal, arrangedSubviews: [expertiseTitleLabel, expertiseLabel])
        
        let rightStackView = equllyStackView(axis: .vertical, arrangedSubviews: [specializationStackView, swiftnessStackView, expertiseStackView])
        
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private func equllyStackView(axis: NSLayoutConstraint.Axis, arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
    private let largeFontSize = 18
    private let smallFontSize = 15
    
    private lazy var attackTitleLabel = makeLable(size: largeFontSize, text: "공격력")
    private lazy var vitalityTitleLabel = makeLable(size: largeFontSize, text: "생명력")
    private lazy var critTitleLabel = makeLable(size: smallFontSize, text: "치명")
    private lazy var specializationTitleLabel = makeLable(size: smallFontSize, text: "특화")
    private lazy var dominationTitleLabel = makeLable(size: smallFontSize, text: "제압")
    private lazy var swiftnessTitleLabel = makeLable(size: smallFontSize, text: "신속")
    private lazy var enduranceTitleLabel = makeLable(size: smallFontSize, text: "인내")
    private lazy var expertiseTitleLabel = makeLable(size: smallFontSize, text: "숙련")
    
    private lazy var attackLabel = makeLable(size: smallFontSize, color: .red)
    private lazy var vitalityLabel = makeLable(size: smallFontSize, color: .red)
    private lazy var critLabel = makeLable(size: smallFontSize, color: .red)
    private lazy var specializationLabel = makeLable(size: smallFontSize, color: .red)
    private lazy var dominationLabel = makeLable(size: smallFontSize, color: .red)
    private lazy var swiftnessLabel = makeLable(size: smallFontSize, color: .red)
    private lazy var enduranceLabel = makeLable(size: smallFontSize, color: .red)
    private lazy var expertiseLabel = makeLable(size: smallFontSize, color: .red)
    
    private func makeLable(size: Int, color: UIColor = .label, text: String = "10000") -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: size, family: .Bold)
        label.textColor = color
        label.text = text
        
        return label
    }
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .tableViewColor
        
        self.contentView.addSubview(backView)
        self.backView.addSubview(mainStackView)
        
        backView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
        topStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
    }
}
