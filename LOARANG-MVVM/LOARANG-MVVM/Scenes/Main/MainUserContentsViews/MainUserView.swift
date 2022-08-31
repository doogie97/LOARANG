//
//  MainUserView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/31.
//

import SnapKit

final class MainUserView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, lvNameLabel, bottomStackView])
        stackView.backgroundColor = .cellColor
        stackView.layer.cornerRadius = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        
        lvNameLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        return stackView
    }()
    //MARK: - top StackView
    private lazy var topStackView: UIStackView = {
        let spaceView = UIView()
        
        spaceView.snp.makeConstraints {
            $0.height.equalTo(8)
        }
        
        let stackView = UIStackView(arrangedSubviews: [spaceView, userImageView])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIScreen.main.bounds.width / 5.2
        return imageView
    }()
    
    //MARK: - bottom StackView
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lvNameLabel,
                                                       makeInfoStackView(classTitle, classLabel),
                                                       makeInfoStackView(itemLvTitle, itemLvLabel),
                                                       makeInfoStackView(serverTitle, serverLabel)])

        
        stackView.distribution = .fillEqually
        stackView.spacing = 50
        return stackView
    }()
    
    private func makeTitleStackView(_ title: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [title])
        stackView.alignment = .bottom
        
        return stackView
    }
    
    private func makeInfoStackView(_ title: UILabel, _ info: UILabel) -> UIStackView {
        let stckaView = UIStackView(arrangedSubviews: [title, info])
        stckaView.distribution = .fillEqually
        stckaView.spacing =  -20
        stckaView.axis = .vertical
        
        return stckaView
    }
    
    private func makeLabel(_ size: Int) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: size, family: .Bold)
        
        return label
    }

    private lazy var classTitle = makeLabel(16)
    private lazy var itemLvTitle = makeLabel(16)
    private lazy var serverTitle = makeLabel(16)
    
    private lazy var lvNameLabel = makeLabel(18)
    private lazy var classLabel = makeLabel(16)
    private lazy var itemLvLabel = makeLabel(16)
    private lazy var serverLabel = makeLabel(16)
    
    private lazy var noMainUserLabel = makeLabel(20)
    
    private func setBackgroundColor() {
        self.backgroundColor = .tableViewColor
    }
    
    private func setLayout() {
        setBackgroundColor()
        
        self.addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func setUserLayout() {
        backView.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        topStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        userImageView.snp.makeConstraints {
            $0.width.equalTo(userImageView.snp.height)
        }
    }
    
    private func setNoMainUserLayout() {
        backView.addSubview(noMainUserLabel)
        
        noMainUserLabel.text = "등록된 대표 캐릭터가 없습니다"
        
        noMainUserLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setUserInfo(_ info: MainUser?) {
        guard let info = info else {
            setNoMainUserLayout()
            return
        }

        setUserLayout()
        classTitle.text = "클래스"
        itemLvTitle.text = "아이템"
        serverTitle.text = "서버"
        
        lvNameLabel.text = "Lv \(info.battleLV) \(info.name)"
        itemLvLabel.text = info.itemLV
        classLabel.text = info.`class`
        serverLabel.text = "\(info.server)"
        userImageView.image = info.image.cropImage(class: info.`class`)
    }
}
