//
//  MainView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import SnapKit

final class MainView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainBackground
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, searchButton])
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "LOARANG"
        label.font = UIFont.BlackHanSans(size: 35)
        label.textColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular, scale: .default), forImageIn: .normal)

        return button
    }()
    
    private func setLayout() {
        self.addSubview(titleStackView)
        
        titleStackView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        title.snp.makeConstraints{
            $0.height.equalTo(50)
        }
    }
}
