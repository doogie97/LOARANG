//
//  GemDetailView.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit
import Alamofire

final class GemDetailView: UIView {
    func setViewContents() {
        let testView = UIView()
        testView.backgroundColor = .cellBackgroundColor
        self.addSubview(testView)
        testView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 2 / 3)
        }
        setLayout()
    }
    
    private func setLayout() {
        
    }
}
