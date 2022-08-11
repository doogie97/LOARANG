//
//  MainInfoTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import SnapKit

final class MainInfoTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainFontSize = 13
    
    private lazy var mainStackView: UIStackView = {
        let emptyView = UIView()
        let stackView = UIStackView(arrangedSubviews: [emptyView, imageClassStackView, mainInfoStackView])
        stackView.spacing = 10
        stackView.backgroundColor = .cellColor
        stackView.layer.cornerRadius = 10

        
        emptyView.snp.makeConstraints {
            $0.width.equalTo(1)
        }
        
        return stackView
    }()
    
    //MARK: - 캐릭터 이미지 + 클래스명 스택뷰
    private lazy var imageClassStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),
                                                       userImageView,
                                                       classLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIScreen.main.bounds.width / 7
        return imageView
    }()
    
    private lazy var classLabel = makeLabel(size: mainFontSize, alignment: .center)
    
    private func makeLabel(size: Int, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = UIFont.one(size: size, family: .Bold)
        label.textAlignment = alignment
        label.textColor = .label
        
        return label
    }
    
    //MARK: - 기본 정보 스택뷰
    
    private lazy var mainInfoStackView: UIStackView = {
        let topEmptyView = UIView()
        let bottomEmptyView = UIView()
        
        let stackView = UIStackView(arrangedSubviews: [topEmptyView,
                                                       serverNameLabel,
                                                       bottomStackView,
                                                       bottomEmptyView])
        stackView.axis = .vertical
        
        topEmptyView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.04)
        }
        
        bottomEmptyView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
        
        return stackView
    }()
    
    private lazy var serverNameLabel = makeLabel(size: 16, alignment: .left)
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemPVPStackView,
                                                       expeditionBattleLvStackView,
                                                       titleLabel,
                                                       guildLabel,
                                                       wisdomLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var itemPVPStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemLvLabel, pvpLabel])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var itemLvLabel = makeLabel(size: mainFontSize, alignment: .left)
    private lazy var pvpLabel = makeLabel(size: mainFontSize, alignment: .left)
    
    private lazy var expeditionBattleLvStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [expeditionLvLabel, battleLvLabel])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var expeditionLvLabel = makeLabel(size: mainFontSize, alignment: .left)
    private lazy var battleLvLabel = makeLabel(size: mainFontSize, alignment: .left)
    
    private lazy var titleLabel = makeLabel(size: mainFontSize, alignment: .left)
    private lazy var guildLabel = makeLabel(size: mainFontSize, alignment: .left)
    private lazy var wisdomLabel = makeLabel(size: mainFontSize, alignment: .left)
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        
        self.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        setLeftStackView()
        setRightStackView()
    }
    
    private func setLeftStackView() {
        imageClassStackView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        userImageView.snp.makeConstraints {
            $0.width.equalTo(userImageView.snp.height)
        }

        classLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    private func setRightStackView() {
        serverNameLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    func setCellContents(_ mainInfo: MainInfo) {
        classLabel.text = mainInfo.`class`
        serverNameLabel.text = "\(mainInfo.server) \(mainInfo.name)"
        itemLvLabel.text = "아이템 : \(mainInfo.itemLV)"
        pvpLabel.text = "PVP : \(mainInfo.pvp)"
        expeditionLvLabel.text = "원정대 : \(mainInfo.expeditionLV)"
        battleLvLabel.text = "전투 레벨 : \(mainInfo.battleLV)"
        titleLabel.text = "칭호 : \(mainInfo.title)"
        guildLabel.text = "길드 : \(mainInfo.guild)"
        wisdomLabel.text = "영지 : \(mainInfo.wisdom)"
        userImageView.image = mainInfo.userImage.cropImage(class: mainInfo.`class`)
    }
}
