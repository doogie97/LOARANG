//
//  MainUserTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

final class MainUserTVCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var backgourndView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        view.addSubview(mainStackView)
        
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
        imageView.image = UIImage(named: "최지근")?.cropImage(class: "블레이드") //test code
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
    
    private func setBackgroundColor() {
        self.backgroundColor = .tableViewColor
    }
    
    private func setLayout() {
        setBackgroundColor()
        self.selectionStyle = .none
        
        self.contentView.addSubview(backgourndView)
        backgourndView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
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
    
    func setUserInfo(_ info: BasicInfo) {
        classTitle.text = "클래스"
        itemLvTitle.text = "아이템"
        serverTitle.text = "서버"
        
        lvNameLabel.text = "Lv \(info.battleLV) \(info.name)"
        itemLvLabel.text = info.itemLV
        classLabel.text = info.`class`
        serverLabel.text = "@\(info.server)"
        //이미지 로드 기능 추가 후 이미지 할당 기능 추가 필요
    }
}
