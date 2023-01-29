//
//  MarketDetailView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/29.
//

import SnapKit

final class MarketDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        
        return button
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        
        self.addSubview(closeButton)
        
        closeButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
