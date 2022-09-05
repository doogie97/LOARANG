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
        let stackView = UIStackView(arrangedSubviews: [segmentControl, pageView])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .cellColor
        
        segmentControl.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        return stackView
    }()
    
    private(set) lazy var segmentControl: CustomSegmentControl = {
        let segmentControl = CustomSegmentControl(segmentTitles: ["장비",
                                                                  "아바타"])
        
        segmentControl.selectedFontColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        segmentControl.selectedFont = .one(size: 14, family: .Bold)
        segmentControl.deselectedFont = .one(size: 14, family: .Light)
        
        return segmentControl
    }()
    
    private(set) lazy var pageView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private func setLayout() {
        self.backgroundColor = .cellBackgroundColor
        self.segmentControl.backgroundColor = .tableViewColor
        self.segmentControl.layer.cornerRadius = 10
        self.segmentControl.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
