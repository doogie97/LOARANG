//
//  BasicInfoView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import SnapKit

final class BasicInfoView: UIView {
    init(engravingsViewHeight: CGFloat) {
        super.init(frame: .zero)
        setLayout(engravingsViewHeight: engravingsViewHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var basicInfoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .mainBackground
        
        return scrollView
    }()
    
    private lazy var basicInfoContentsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private(set) lazy var mainInfoView = MainInfoView()
    private(set) lazy var basicAbillityView = BasicAbillityView()
    private(set) lazy var equipmentsView = EquipmentsView()
    private(set) lazy var engravingsView = EngravingsView()
    private(set) lazy var propensitiesView = PropensitiesView()
    
    private(set) lazy var engravingDetailView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .black
        view.layer.cornerRadius = 10

        view.addSubview(engravingEffectLabel)
        view.addSubview(engravingTitleLabel)
        view.addSubview(xMarkLabel)
        
        engravingTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }

        engravingEffectLabel.snp.makeConstraints {
            $0.top.equalTo(engravingTitleLabel.snp.bottom).inset(-8)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        xMarkLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
        }
        
        return view
    }()
    
    private lazy var engravingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 15, family: .Bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var engravingEffectLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 13, family: .Regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var xMarkLabel: UILabel = {
        let label = UILabel()
        label.text = "×"
        label.font = .one(size: 15, family: .Bold)
        
        return label
    }()
    
    private func setLayout(engravingsViewHeight: CGFloat) {
        self.addSubview(basicInfoScrollView)
        basicInfoScrollView.addSubview(basicInfoContentsView)
        basicInfoContentsView.addSubview(mainInfoView)
        basicInfoContentsView.addSubview(basicAbillityView)
        basicInfoContentsView.addSubview(propensitiesView)
        basicInfoContentsView.addSubview(equipmentsView)
        basicInfoContentsView.addSubview(engravingsView)
        
        
        basicInfoScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        basicInfoContentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainInfoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        basicAbillityView.snp.makeConstraints {
            $0.top.equalTo(mainInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        propensitiesView.snp.makeConstraints {
            $0.top.equalTo(basicAbillityView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        equipmentsView.snp.makeConstraints {
            $0.top.equalTo(propensitiesView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 1.3)
        }
        
        engravingsView.snp.makeConstraints {
            $0.top.equalTo(equipmentsView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(engravingsViewHeight)
            $0.bottom.equalToSuperview()
        }
        
        self.addSubview(engravingDetailView)
        
        engravingDetailView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(5)
            $0.centerY.equalTo(engravingsView)
            $0.height.greaterThanOrEqualTo(15)
        }
    }
    
    func showEngravingDetail(engraving: Engraving) {
        engravingDetailView.isHidden = false
        
        engravingTitleLabel.text = engraving.title
        engravingEffectLabel.text = engraving.describtion
    }
}
