//
//  CharcterDetailSkillCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CharcterDetailSkillCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 6
        
        view.backgroundColor = .cellColor
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [basicStackView, tripodsStackView, runeLabelView, gemLabelView])
        stackView.axis = .vertical
        stackView.spacing = 10

        return stackView
    }()
    
    //MARK: - Basic StackView
    private lazy var basicStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [skillImageView, skillNameLabel, skillLvLabel])
        stackView.spacing = 10
        
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
    
    private lazy var skillNameLabel = pretendardLabel(size: 16, family: .SemiBold)
    
    private lazy var skillLvLabel = pretendardLabel(size: 14, family: .SemiBold, color:  #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), alignment: .right)
    
    //MARK: - Tripods StackView
    
    private lazy var tripodsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstTripodStackView, secondTripodStackView, thridTripodStackView])
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .mainBackground
        stackView.layer.cornerRadius = 6
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 3, right: 5)
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
    private lazy var runeLabelView = makeLabelView(label: runeLabel)
    private lazy var gemLabel = makePaddingLabel()
    private lazy var gemLabelView = makeLabelView(label: gemLabel)
    
    private func makeLabelView(label: UILabel) -> UIView {
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        view.layer.cornerRadius = 6
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        return view
    }
    
    private func makePaddingLabel() -> PaddingLabel {
        let label = PaddingLabel(top: 8, bottom: 8, left: 0, right: 0)
        label.font = .one(size: 12, family: .Regular)
        label.numberOfLines = 2
        
        return label
    }
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        
        self.contentView.addSubview(backView)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func setCellContents(skill: Skill) {
        skillImageView.setImage(skill.imageURL)
        skillNameLabel.text = skill.name
        skillLvLabel.text = skill.skillLv
        
        if (skill.tripods.first?.name ?? "").isEmpty {
            tripodsStackView.isHidden = true
        } else {
            firstTripodNameLabel.text = skill.tripods[safe: 0]?.name
            firstTripodImageView.setImage(skill.tripods[safe: 0]?.imageURL)
            
            secondTripodNameLabel.text = skill.tripods[safe: 1]?.name
            secondTripodImageView.setImage(skill.tripods[safe: 1]?.imageURL)
            
            thirdTripodNameLabel.text = skill.tripods[safe: 2]?.name
            thirdTripodImageView.setImage(skill.tripods[safe: 2]?.imageURL)
        }

        
        if (skill.runeEffect?.description ?? "").isEmpty {
            runeLabel.text = " 장착 룬 없음"
        } else {
            runeLabel.attributedText = skill.runeEffect
        }

        if (skill.gemEffect?.description ?? "").isEmpty {
            gemLabel.text = " 장착 보석 없음"
        } else {
            gemLabel.attributedText = skill.gemEffect
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skillImageView.kf.cancelDownloadTask()
        skillImageView.image = nil
        
        skillNameLabel.text = nil
        skillLvLabel.text = nil
        
        firstTripodNameLabel.text = nil
        firstTripodImageView.kf.cancelDownloadTask()
        firstTripodImageView.image = nil
        
        secondTripodNameLabel.text = nil
        secondTripodImageView.kf.cancelDownloadTask()
        secondTripodImageView.image = nil
        
        thirdTripodNameLabel.text = nil
        thirdTripodImageView.kf.cancelDownloadTask()
        thirdTripodImageView.image = nil
        
        runeLabel.text = nil
        gemLabel.text = nil
        
        tripodsStackView.isHidden = false
    }
}