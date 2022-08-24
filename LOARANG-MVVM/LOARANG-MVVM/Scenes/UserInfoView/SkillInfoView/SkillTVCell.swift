//
//  SkillTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

import SnapKit

final class SkillTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        
        view.backgroundColor = .cellColor
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [basicStackView])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    //MARK: - Basic StackView
    private lazy var basicStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [skillImageView, skillNameLabel, skillLvLabel])
        stackView.spacing = 5
        
        skillImageView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        
        skillNameLabel.snp.makeConstraints {
            $0.width.equalTo(skillLvLabel)
        }
        
        return stackView
    }()
    
    private lazy var skillImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var skillNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    private lazy var skillLvLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()

    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        
        self.contentView.addSubview(backView)
        
        backView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview()
        }
    }
    
    func setCellContents(skill: Skill) {
        skillImageView.setImage(urlString: skill.imageURL)
        skillNameLabel.text = skill.name
        skillLvLabel.text = skill.skillLv
    }
}
