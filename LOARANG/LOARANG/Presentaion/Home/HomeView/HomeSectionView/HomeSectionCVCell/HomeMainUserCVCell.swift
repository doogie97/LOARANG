//
//  HomeMainUserCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit
import RxSwift

final class HomeMainUserCVCell: UICollectionViewCell {
    private weak var viewModel: HomeVMable?
    private var disposeBag = DisposeBag()
    
    //MARK: - UserInfoView
    private lazy var userInfoView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 6
        view.addSubview(classLabelView)
        view.addSubview(characterImageView)
        view.addSubview(characterNameLabel)
        view.addSubview(bottomInfoView)
        view.addSubview(detailInfoButton)
        
        classLabelView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(margin(.width, 16))
        }
        
        characterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.width, 8))
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(imageWidth)
        }
        
        characterNameLabel.setContentHuggingPriority(.required, for: .vertical)
        characterNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        characterNameLabel.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).inset(margin(.width, -8))
            $0.centerX.equalToSuperview()
        }
        
        bottomInfoView.snp.makeConstraints {
            $0.top.equalTo(characterNameLabel.snp.bottom).inset(margin(.width, -10))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
            $0.height.equalTo(73)
        }
        
        detailInfoButton.snp.makeConstraints {
            $0.top.equalTo(bottomInfoView.snp.bottom).inset(margin(.width, -16))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
            $0.height.equalTo(40)
        }
        
        return view
    }()
    
    private lazy var classLabel = {
        let label = PaddingLabel(top: 8, bottom: 8, left: 8, right: 8)
        label.font = .pretendard(size: 12, family: .Bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var classLabelView = {
        let view = UIView()
        let backView = UIView()
        backView.layer.cornerRadius = 6
        backView.backgroundColor = .white
        backView.layer.opacity = 0.05
        
        view.addSubview(backView)
        view.addSubview(classLabel)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        classLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var imageWidth = margin(.width, 150)
    private lazy var characterImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.2
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageWidth / 2
        
        return imageView
    }()
    
    private lazy var characterNameLabel = pretendardLabel(size: 18, family: .Bold, alignment: .center)
    
    private lazy var bottomInfoView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = .cellBackgroundColor
        view.addSubview(bottomInfoStackView)
        bottomInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(margin(.width, 16))
        }
        return view
    }()
    
    private lazy var bottomInfoStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            bottomInfoItemView(title: "아이템", label: itemLvLabel),
            bottomInfoItemView(title: "전투", label: battleLvLabel),
            bottomInfoItemView(title: "원정대", label: expeditionLvLabel)
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var itemLvLabel = pretendardLabel(size: 16, alignment: .center)
    private lazy var battleLvLabel = pretendardLabel(size: 16, alignment: .center)
    private lazy var expeditionLvLabel = pretendardLabel(size: 16, alignment: .center)
    
    private func bottomInfoItemView(title: String, label: UILabel) -> UIView {
        let titleLabel = pretendardLabel(size: 14, family: .Regular, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), alignment: .center)

        titleLabel.text = title
        let view = UIStackView(arrangedSubviews: [titleLabel, label])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 8
        view.alignment = .center
        
        return view
    }
    
    private lazy var detailInfoButton = {
        let button = UIButton(type: .system)
        button.setTitle("자세히 보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .pretendard(size: 14, family: .Bold)
        button.backgroundColor = #colorLiteral(red: 0.3933520469, green: 0.4040421268, blue: 0.9664957529, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(touchDetailInfoButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchDetailInfoButton() {
        viewModel?.touchViewAction(.mainUser)
    }
    
    //MARK: - Empty View
    private lazy var emptyView = {
        let innerView = UIView()
        innerView.addSubview(emptyLabel)
        innerView.addSubview(searchButton)

        emptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(emptyLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 48))
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview()
        }
        
        let view = UIView()
        view.layer.cornerRadius = 6
        view.isHidden = true
        view.backgroundColor = .cellColor
        
        view.addSubview(innerView)
        
        innerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        return view
    }()
    
    private lazy var emptyLabel = pretendardLabel(size: 16, family: .Regular, text: "대표 캐릭터를 설정하고\n빠르게 내 캐릭터를 확인해 보세요! 😁", alignment: .center, lineCount: 2)
    
    private lazy var searchButton = {
        let button = UIButton(type: .system)
        button.setTitle("대표 캐릭터 등록하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .pretendard(size: 14, family: .Bold)
        button.backgroundColor = #colorLiteral(red: 0.3933520469, green: 0.4040421268, blue: 0.9664957529, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(touchRegistMainUserButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchRegistMainUserButton() {
        viewModel?.touchViewAction(.touchRegistMainUserButton)
    }
    
    func setCellContents(viewModel: HomeVMable?) {
        self.viewModel = viewModel
        bindViewChangeManager()
        setLayout()
    }
    
    private func bindViewChangeManager() {
        ViewChangeManager.shared.mainUser.withUnretained(self)
            .subscribe { owner, mainUserInfo in
                owner.setUserInfo(mainUserInfo)
            }
            .disposed(by: disposeBag)
    }
    
    private func setUserInfo(_ userInfo: MainUserEntity?) {
        if let userInfo = userInfo {
            classLabel.text = userInfo.`class`
            characterImageView.image = userInfo.image.cropImage(class: userInfo.`class`)
            characterNameLabel.text = userInfo.name + " " + userInfo.server
            characterNameLabel.asFontColor(targetString: userInfo.server,
                                           font: .pretendard(size: 14, family: .Regular),
                                           color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            itemLvLabel.text = userInfo.itemLV.replacingOccurrences(of: ",", with: "")
            battleLvLabel.text = "Lv." + userInfo.battleLV.description
            expeditionLvLabel.text = "Lv." + userInfo.expeditionLV.description
            userInfoView.isHidden = false
        } else {
            emptyView.isHidden = false
        }
    }
    
    private func setLayout() {
        let topSeparator = UIView()
        topSeparator.backgroundColor = .tableViewColor
        
        self.contentView.addSubview(topSeparator)
        self.contentView.addSubview(userInfoView)
        self.addSubview(emptyView)
        
        topSeparator.snp.makeConstraints {
            $0.top.left.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        userInfoView.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).inset(margin(.width, -10))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 10))
            $0.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).inset(margin(.width, -10))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
            $0.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        userInfoView.isHidden = true
        emptyView.isHidden = true
    }
}
