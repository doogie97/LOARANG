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
            battleLvLabel.text = "Lv." + userInfo.battleLV
            expeditionLvLabel.text = "Lv." + userInfo.expeditionLV
        } else {
            print("없다")
        }
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
    
    private func setLayout() {
        let topSeparator = UIView()
        topSeparator.backgroundColor = .tableViewColor
        let backView = UIView()
        backView.backgroundColor = .cellColor
        backView.layer.cornerRadius = 6
        
        self.contentView.addSubview(topSeparator)
        self.contentView.addSubview(backView)
        backView.addSubview(classLabelView)
        backView.addSubview(characterImageView)
        backView.addSubview(characterNameLabel)
        backView.addSubview(bottomInfoView)
        backView.addSubview(detailInfoButton)
        
        classLabelView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(margin(.width, 16))
        }
        
        topSeparator.snp.makeConstraints {
            $0.top.left.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        backView.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).inset(margin(.width, -10))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 10))
            $0.bottom.equalToSuperview()
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
