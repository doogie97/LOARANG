//
//  LoadingView.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import UIKit
import SnapKit

final class LoadingView: UIView {
    init() {
        super.init(frame: .zero)
        self.isHidden = true
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.stopAnimating()
        indicator.color = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        
        return indicator
    }()
    
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            self.isHidden = false
            activityIndicator.startAnimating()
        } else {
            self.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    private func setLayout() {
        self.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
