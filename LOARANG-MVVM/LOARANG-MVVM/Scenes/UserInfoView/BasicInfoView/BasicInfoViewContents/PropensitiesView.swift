//
//  PropensitiesView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/02.
//

import SnapKit

final class PropensitiesView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 18, family: .Bold)
        label.text = "성향"
        label.textAlignment = .center
        label.backgroundColor = .red
        
        return label
    }()
    
    private lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let largeFontSize = 15
    private let smallFontSize = 15
    private let statColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    
    private lazy var intellectTitleLabel = makeLable(size: largeFontSize, text: "지성")
    private lazy var intellectLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var intellectStackView = makeStackView(arrangedSubviews: [intellectTitleLabel,
                                                                           intellectLabel])
    
    private lazy var courageTitleLabel = makeLable(size: largeFontSize, text: "담력")
    private lazy var courageLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var courageStackView = makeStackView(arrangedSubviews: [courageTitleLabel,
                                                                           courageLabel])
    
    private lazy var charmTitleLabel = makeLable(size: largeFontSize, text: "매력")
    private lazy var charmLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var charmStackView = makeStackView(arrangedSubviews: [charmTitleLabel,
                                                                       charmLabel])
    
    private lazy var kindnessTitleLabel = makeLable(size: largeFontSize, text: "친절")
    private lazy var kindnessLabel = makeLable(size: smallFontSize, color: statColor)
    private lazy var kindnessStackView = makeStackView(arrangedSubviews: [kindnessTitleLabel,
                                                                          kindnessLabel])
    
    private func makeLable(size: Int, color: UIColor = .label, text: String = "") -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: size, family: .Bold)
        label.textColor = color
        label.text = text
        
        return label
    }
    
    private func makeStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        
        return stackView
    }
    
    private func setLayout() {
        self.backgroundColor = .cellBackgroundColor
        
        self.addSubview(contentsView)
        
        contentsView.addSubview(intellectStackView)
        contentsView.addSubview(courageStackView)
        contentsView.addSubview(charmStackView)
        contentsView.addSubview(kindnessStackView)
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        intellectStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().multipliedBy(0.5)
        }
        
        courageStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(intellectStackView.snp.trailing)
            $0.trailing.equalToSuperview()
        }
        
        charmStackView.snp.makeConstraints {
            $0.top.equalTo(intellectStackView.snp.bottom).inset(-16)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().multipliedBy(0.5)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        kindnessStackView.snp.makeConstraints {
            $0.top.equalTo(courageStackView.snp.bottom).inset(-16)
            $0.leading.equalTo(charmStackView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setViewContents(propensities: Propensities) {
        intellectLabel.text = propensities.intellect
        courageLabel.text = propensities.courage
        charmLabel.text = propensities.charm
        kindnessLabel.text = propensities.kindness
    }
}
