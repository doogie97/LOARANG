//
//  EquipmentsView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import SnapKit

final class EquipmentsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentControllView, pageView])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .cellColor
        
        segmentControllView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        return stackView
    }()
    
    private(set) lazy var segmentControllView = SegmentControllerView(frame: .zero,
                                                                      segmentTitles: ["장비",
                                                                                      "아바타",
                                                                                      "캐릭터 이미지"])
    
    private(set) lazy var pageView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private func setLayout() {
        self.backgroundColor = .cellBackgroundColor
        self.segmentControllView.backgroundColor = .tableViewColor
        self.segmentControllView.layer.cornerRadius = 10
        self.segmentControllView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
    }
}
