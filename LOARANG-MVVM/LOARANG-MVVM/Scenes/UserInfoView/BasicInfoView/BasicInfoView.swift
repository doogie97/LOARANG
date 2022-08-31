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
    
    private func setLayout(engravingsViewHeight: CGFloat) {
        self.addSubview(basicInfoScrollView)
        basicInfoScrollView.addSubview(basicInfoContentsView)
        basicInfoContentsView.addSubview(mainInfoView)
        basicInfoContentsView.addSubview(basicAbillityView)
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
            $0.height.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        
        basicAbillityView.snp.makeConstraints {
            $0.top.equalTo(mainInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 0.4)
        }
        
        equipmentsView.snp.makeConstraints {
            $0.top.equalTo(basicAbillityView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 1.3)
        }
        
        engravingsView.snp.makeConstraints {
            $0.top.equalTo(equipmentsView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(engravingsViewHeight)
            $0.bottom.equalToSuperview()
        }
    }
}
