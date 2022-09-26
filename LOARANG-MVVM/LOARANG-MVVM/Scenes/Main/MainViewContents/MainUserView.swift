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
    
    private lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private(set) lazy var setMainUserButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .systemGray
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 18, weight: .regular, scale: .default), forImageIn: .normal)

        return button
    }()
    
    //MARK: - bottom StackView
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [makeInfoStackView(classTitle, classLabel),
                                                       makeInfoStackView(itemLvTitle, itemLvLabel),
                                                       makeInfoStackView(serverTitle, serverLabel)])

        
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private func makeInfoStackView(_ title: UILabel, _ info: UILabel) -> UIStackView {
        let stckaView = UIStackView(arrangedSubviews: [title, info])
        stckaView.distribution = .fillEqually
        stckaView.axis = .vertical
        stckaView.spacing = 20
        
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
    
    private lazy var lvNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.one(size: 18, family: .Bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    private lazy var classLabel = makeLabel(16)
    private lazy var itemLvLabel = makeLabel(16)
    private lazy var serverLabel = makeLabel(16)
    
    private lazy var noMainUserLabel = makeLabel(20)
    
    private func setLayout() {
        self.addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func setUserLayout() {
        contentsView.addSubview(userImageView)
        contentsView.addSubview(lvNameLabel)
        contentsView.addSubview(bottomStackView)
        
        userImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            
            let height = UIScreen.main.bounds.width * 0.4
            $0.height.equalTo(height)
            $0.width.equalTo(userImageView.snp.height)
            userImageView.layer.cornerRadius = height / 2
        }
        
        lvNameLabel.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(lvNameLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setNoMainUserLayout() {
        backView.addSubview(noMainUserLabel)
        
        noMainUserLabel.text = "등록된 대표 캐릭터가 없습니다"
        
        noMainUserLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 0.7)
        }
    }
    
    func setUserInfo(_ info: MainUser?) {
        backView.addSubview(contentsView)
        contentsView.addSubview(setMainUserButton)
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        setMainUserButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
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
