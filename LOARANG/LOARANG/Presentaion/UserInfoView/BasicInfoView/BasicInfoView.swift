//
//  BasicInfoView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import UIKit
import SnapKit

final class BasicInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var basicInfoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .mainBackground
        
        return scrollView
    }()
    
    private lazy var basicInfoContentsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private(set) lazy var mainInfoView = MainInfoView()
    private(set) lazy var basicAbillityView = BasicAbillityView()
    private(set) lazy var propensitiesView = PropensitiesView()
    private(set) lazy var equipmentsView = EquipmentsView()
    private(set) lazy var engravingsView = EngravingsView()
    private(set) lazy var cardView = CardView()
    private(set) lazy var characterImageView = CharacterImageView()
    
    private(set) lazy var engravingDetailView: UIView = {
        let view = UIView()
        let guesture = UITapGestureRecognizer(target: self, action: #selector(engravingDetail))
        view.addGestureRecognizer(guesture)
        view.isHidden = true
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 0.5

        view.addSubview(engravingEffectLabel)
        view.addSubview(engravingTitleLabel)
        view.addSubview(xMarkLabel)
        
        engravingTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }

        engravingEffectLabel.snp.makeConstraints {
            $0.top.equalTo(engravingTitleLabel.snp.bottom).inset(-8)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        xMarkLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
        }
        
        return view
    }()
    
    private lazy var engravingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 15, family: .Bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var engravingEffectLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 13, family: .Regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var xMarkLabel: UILabel = {
        let label = UILabel()
        label.text = "×"
        label.font = .one(size: 15, family: .Bold)
        
        return label
    }()
    
    @objc private func engravingDetail() {
        self.engravingDetailView.isHidden = true
    }
    
    private func setLayout() {
        self.addSubview(basicInfoScrollView)
        basicInfoScrollView.addSubview(basicInfoContentsView)
        basicInfoContentsView.addSubview(mainInfoView)
        basicInfoContentsView.addSubview(basicAbillityView)
        basicInfoContentsView.addSubview(propensitiesView)
        basicInfoContentsView.addSubview(equipmentsView)
        basicInfoContentsView.addSubview(engravingsView)
        basicInfoContentsView.addSubview(cardView)
        basicInfoContentsView.addSubview(characterImageView)
        
        
        basicInfoScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        basicInfoContentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        basicAbillityView.snp.makeConstraints {
            $0.top.equalTo(mainInfoView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        propensitiesView.snp.makeConstraints {
            $0.top.equalTo(basicAbillityView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        equipmentsView.snp.makeConstraints {
            $0.top.equalTo(propensitiesView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(UIScreen.main.bounds.width * 1.3)
        }
        
        engravingsView.snp.makeConstraints {
            $0.top.equalTo(equipmentsView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(engravingsView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        characterImageView.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(UIScreen.main.bounds.width * 1.15)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        self.addSubview(engravingDetailView)
        
        engravingDetailView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(5)
            $0.centerY.equalTo(engravingsView)
            $0.height.greaterThanOrEqualTo(15)
        }
    }
    
    func showEngravingDetail(engraving: Engraving) {
        engravingDetailView.isHidden = false
        
        engravingTitleLabel.text = engraving.title
        engravingEffectLabel.attributedText = engraving.describtion.stringWithSpacing(4)
    }
    
    func setViewContents(userInfo: UserInfo) {
        basicInfoScrollView.setContentOffset(.zero, animated: true)
        mainInfoView.setViewContents(userInfo.mainInfo)
        basicAbillityView.setViewContents(userInfo.stat.basicAbility)
        propensitiesView.setViewContents(propensities: userInfo.stat.propensities)
        engravingsView.setLayout(isNoEngraving: userInfo.stat.engravigs.count == 0,
                                 collectionViewHeight: userInfo.stat.engravigs.count.engravingHeight)
        cardView.setLayout(isNoCard: userInfo.userJsonInfo.cardInfo.cards.count == 0)
        characterImageView.setUserImageView(userInfo.mainInfo.userImage)
    }
}
