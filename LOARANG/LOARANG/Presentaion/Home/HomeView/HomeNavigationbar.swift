//
//  HomeNavigationbar.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeNavigationbar: UIView {
    private weak var viewModel: HomeVMable?
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "LOARANG"
        label.font = UIFont.BlackHanSans(size: 35)
        label.textColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        return label
    }()
    
    private lazy var leafImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leafImg")
        
        return imageView
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular, scale: .default), forImageIn: .normal)
        button.addTarget(self, action: #selector(touchSearchButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchSearchButton() {
        viewModel?.touchSearchButton()
    }
    
    func setViewContents(viewModel: HomeVMable?) {
        self.viewModel = viewModel
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(title)
        self.addSubview(leafImageView)
        self.addSubview(searchButton)
        
        title.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(margin(.width, 20))
            $0.height.equalTo(50)
        }
        
        leafImageView.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.leading.equalTo(title.snp.trailing).inset(-3)
            $0.top.equalTo(title).inset(10)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(80)
        }
    }
}
