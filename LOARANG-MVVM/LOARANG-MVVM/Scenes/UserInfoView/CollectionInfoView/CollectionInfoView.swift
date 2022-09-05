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
    
    private func setLayout() {
        self.backgroundColor = .yellow
    }
}
