//
//  SkillDetailView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import SnapKit

final class SkillDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return button
    }()
    
    private lazy var nameLabel = makeLabel(alignment: .center, font: .one(size: 20, family: .Bold))
    
    private lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    private lazy var skillImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    private lazy var skillTypeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [actionTypeLabel, skillTypeLabel])
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var actionTypeLabel = UILabel()
    private lazy var skillTypeLabel = UILabel()
    
    private lazy var coolTimeLabel = UILabel()

    private lazy var skillLvBattleTypeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [skillLvLabel, battleTypeLabel])
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        
        return stackView
    }()
    
    private lazy var skillLvLabel = makeLabel(alignment: .left, font: .one(size: 13, family: .Bold), color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    private lazy var battleTypeLabel = UILabel()
    
    private lazy var effetcLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var tripodsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mainBackground
        tableView.isScrollEnabled = false
        tableView.register(TripodTVCell.self)
        
        return tableView
    }()
    
    private func makeLabel(alignment: NSTextAlignment, font: UIFont, color: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.font = font
        label.textColor = color
        
        return label
    }
    
    private func setLayout() {
        self.backgroundColor = .mainBackground
        self.addSubview(closeButton)
        self.addSubview(nameLabel)
        self.addSubview(underline)
        self.addSubview(skillImageView)
        self.addSubview(skillTypeStackView)
        self.addSubview(coolTimeLabel)
        self.addSubview(skillLvBattleTypeStackView)
        self.addSubview(effetcLabel)
        self.addSubview(tripodsTableView)
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(15)
            $0.centerY.equalTo(nameLabel)
            $0.height.width.equalTo(30)
        }
     
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        underline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-15)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        skillImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(skillImageView.snp.width)
            $0.top.equalTo(underline.snp.bottom).inset(-20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        skillTypeStackView.snp.makeConstraints {
            $0.top.equalTo(skillImageView.snp.top)
            $0.leading.equalTo(skillImageView.snp.trailing).inset(-15)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        coolTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(skillImageView.snp.centerY)
            $0.leading.equalTo(skillImageView.snp.trailing).inset(-15)
        }
        
        skillLvBattleTypeStackView.snp.makeConstraints {
            $0.bottom.equalTo(skillImageView.snp.bottom)
            $0.leading.equalTo(skillImageView.snp.trailing).inset(-15)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        effetcLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(skillImageView.snp.bottom).inset(-16)
        }
        
        tripodsTableView.snp.makeConstraints {
            $0.top.equalTo(effetcLabel.snp.bottom).inset(-20)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(15)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setViewContents(_ skill: Skill) {
        nameLabel.text = skill.name
        skillImageView.setImage(urlString: skill.imageURL)
        actionTypeLabel.attributedText = skill.actionType.htmlToAttributedString(fontSize: 4, alignment: .LEFT)
        skillTypeLabel.attributedText = skill.skillType.htmlToAttributedString(fontSize: 4, alignment: .RIGHT)
        coolTimeLabel.attributedText = skill.coolTime.htmlToAttributedString(fontSize: 5, alignment: .LEFT)
        skillLvLabel.text = skill.skillLv
        battleTypeLabel.attributedText = skill.battleType.htmlToAttributedString(fontSize: 4, alignment: .RIGHT)
        effetcLabel.attributedText = skill.skillDescription.htmlToAttributedString(fontSize: 5)
    }
}
