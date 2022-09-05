//
//  CollectionInfoView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/05.
//

import SnapKit

final class CollectionInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let menuScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.cornerRadius = 5
        scrollView.backgroundColor = #colorLiteral(red: 0.1659600362, green: 0.1790002988, blue: 0.1983416486, alpha: 1)
        return scrollView
    }()
    
    private(set) lazy var segmentControl: CustomSegmentControl = {
        let segmentControl = CustomSegmentControl(segmentTitles: ["거인의 심장", "섬의 마음", "모코코 씨앗", "위대한 미술품", "항해 모험물", "세계수의 잎", "이그네아의 징표", "오르페우스의 별", "기억의 오르골"])
        segmentControl.selectedFontColor = .label
        segmentControl.selectedFont = .one(size: 13, family: .Bold)
        segmentControl.deselectedFont = .one(size: 13, family: .Light)
        segmentControl.underLineColor = nil
        segmentControl.backColor = UIColor(white: 0.1, alpha: 0.5)
        
        return segmentControl
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        
        self.addSubview(menuScrollView)
        
        menuScrollView.addSubview(segmentControl)
        
        menuScrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(40)
        }
        
        segmentControl.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width * 2.5)
            $0.height.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(3)
        }
    }
}
