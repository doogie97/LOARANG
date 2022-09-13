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
    
    private(set) lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    private(set) lazy var pageView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackground
        
        return view
    }()
    
    private(set) lazy var segmentControl: CustomSegmentControl = {
        let segmentControl = CustomSegmentControl(segmentTitles: ["기본 정보", "스킬", "보유캐릭터"])
        segmentControl.selectedFontColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        segmentControl.selectedFont = .one(size: 14, family: .Bold)
        segmentControl.deselectedFont = .one(size: 14, family: .Light)
        segmentControl.underLineColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        
        return segmentControl
    }()
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.addSubview(navigationStackView)
        self.addSubview(segmentControl)
        self.addSubview(separatorView)
        self.addSubview(pageView)
        
        navigationStackView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        backButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(navigationStackView.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).inset(-2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        pageView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setViewContents(_ userInfo: UserInfo) {
        setLayout()
        
        self.titleLabel.text = userInfo.mainInfo.name
    }
}
