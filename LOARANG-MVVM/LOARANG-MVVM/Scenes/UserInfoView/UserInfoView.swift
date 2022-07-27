//
//  UserInfoView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import SnapKit

final class UserInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var navigationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel, bookMarkButton])
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 18, family: .Bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .buttonColor
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)

        return button
    }()
    
    private lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        
        return button
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.addSubview(navigationStackView)
        
        navigationStackView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        backButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    func setCellContents(_ userInfo: UserInfo) {
        self.titleLabel.text = userInfo.basicInfo.name
    }
}
