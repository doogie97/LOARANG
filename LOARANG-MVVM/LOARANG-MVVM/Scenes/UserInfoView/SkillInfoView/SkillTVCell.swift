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
        let stackView = UIStackView(arrangedSubviews: [basicStackView, tripodsStackView, runeLabel, gemLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
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
    
    //MARK: - Tripods StackView
    
    private lazy var tripodsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstTripodStackView, secondTripodStackView, thridTripodStackView])
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .mainBackground
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private lazy var firstTripodStackView = makeTripodStackView(imageView: firstTripodImageView,
                                                                nameLabe: firstTripodNameLabel)
    
    private lazy var firstTripodImageView = UIImageView()
    private lazy var firstTripodNameLabel = makeTripodLabel()
    
    private lazy var secondTripodStackView = makeTripodStackView(imageView: secondTripodImageView,
                                                                 nameLabe: secondTripodNameLabel)
    
    private lazy var secondTripodImageView = UIImageView()
    private lazy var secondTripodNameLabel = makeTripodLabel()
    
    private lazy var thridTripodStackView = makeTripodStackView(imageView: thirdTripodImageView,
                                                                nameLabe: thirdTripodNameLabel)
    
    private lazy var thirdTripodImageView = UIImageView()
    private lazy var thirdTripodNameLabel = makeTripodLabel()
    
    private func makeTripodStackView(imageView: UIImageView, nameLabe: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabe])
        stackView.spacing = 5
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.width.equalTo(imageView.snp.height)
        }
        
        return stackView
    }
    
    private func makeTripodLabel() -> UILabel {
        let label = UILabel()
        label.font = .one(size: 11, family: .Bold)
        label.textColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.3882352941, alpha: 1)
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        
        return label
    }
    
    //MARK: - Rune & Gem effect
    private lazy var runeLabel = makePaddingLabel()
    private lazy var gemLabel = makePaddingLabel()
    
    private func makePaddingLabel() -> PaddingLabel {
        let label = PaddingLabel(top: 5, bottom: 5, left: 5, right: 5)
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        label.backgroundColor = .cellBackgroundColor
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }
    
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
        
        firstTripodNameLabel.text = skill.tripods[safe: 0]?.name
        firstTripodImageView.setImage(urlString: skill.tripods[safe: 0]?.imageURL)
        
        secondTripodNameLabel.text = skill.tripods[safe: 1]?.name
        secondTripodImageView.setImage(urlString: skill.tripods[safe: 1]?.imageURL)
        
        thirdTripodNameLabel.text = skill.tripods[safe: 2]?.name
        thirdTripodImageView.setImage(urlString: skill.tripods[safe: 2]?.imageURL)
        
        if (skill.runeEffect?.description ?? "").isEmpty {
            runeLabel.isHidden = true
        } else {
            runeLabel.attributedText = skill.runeEffect
        }
        
        if (skill.gemEffect?.description ?? "").isEmpty {
            gemLabel.isHidden = true
        } else {
            gemLabel.attributedText = skill.gemEffect
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skillImageView.image = nil
        skillNameLabel.text = nil
        skillLvLabel.text = nil
        
        firstTripodNameLabel.text = nil
        firstTripodImageView.image = nil
        
        secondTripodNameLabel.text = nil
        secondTripodImageView.image = nil
        
        thirdTripodNameLabel.text = nil
        thirdTripodImageView.image = nil
        
        runeLabel.attributedText = nil
        gemLabel.attributedText = nil
    }
}
