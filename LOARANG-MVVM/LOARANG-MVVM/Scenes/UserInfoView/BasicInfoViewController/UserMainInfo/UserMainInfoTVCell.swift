//
//  UserMainInfoTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

import SnapKit

final class UserMainInfoTVCell: UITableViewCell {
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
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),imageClassStackView])
        stackView.backgroundColor = .cellColor
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    // 캐릭터 이미지 + 클래스명 스택뷰
    private lazy var imageClassStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),
                                                       userImageView,
                                                       classLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "최지근")?.cropImage(class: "블레이드") //test code
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIScreen.main.bounds.width / 7
        return imageView
    }()
    
    private lazy var classLabel = makeLabel(size: 15, alignment: .center)
    
    private func makeLabel(size: Int, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = UIFont.one(size: size, family: .Bold)
        label.textAlignment = alignment
        label.textColor = .label
        
        return label
    }
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .tableViewColor
        self.contentView.addSubview(backgourndView)
        self.backgourndView.addSubview(mainStackView)
        
        backgourndView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        setLeftStackView()
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
    
    func setCellContents(_ userInfo: UserInfo) {
        self.classLabel.text = userInfo.basicInfo.class
    }
}
