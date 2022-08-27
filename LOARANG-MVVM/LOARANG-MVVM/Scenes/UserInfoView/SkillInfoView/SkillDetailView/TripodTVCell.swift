//
//  TripodTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import SnapKit

final class TripodTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var tripodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "트포기본이미지")

        return imageView
    }()
    
    private lazy var tripodNameLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 14, family: .Bold)
        label.textColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.3882352941, alpha: 1)
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    private lazy var tripodLvLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private lazy var tripodEffectLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .mainBackground
        
        self.contentView.addSubview(tripodImageView)
        self.contentView.addSubview(tripodNameLabel)
        self.contentView.addSubview(tripodLvLabel)
        self.contentView.addSubview(tripodEffectLabel)
        
        tripodImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
            $0.width.equalTo(40)
            $0.height.equalTo(tripodImageView.snp.width)
        }
        
        tripodNameLabel.snp.makeConstraints {
            $0.top.equalTo(tripodImageView.snp.top).inset(2)
            $0.leading.equalTo(tripodImageView.snp.trailing).inset(-10)
            $0.trailing.equalTo(tripodLvLabel.snp.leading)
        }
        
        tripodLvLabel.snp.makeConstraints {
            $0.top.equalTo(tripodImageView.snp.top).inset(2)
            $0.trailing.equalToSuperview()
        }
        
        tripodEffectLabel.snp.makeConstraints {
            $0.top.equalTo(tripodNameLabel.snp.bottom).inset(-5)
            $0.leading.equalTo(tripodImageView.snp.trailing).inset(-10)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setCellContents(tripod: Tripod) {
        if !tripod.name.isEmpty {
            tripodImageView.setImage(urlString: tripod.imageURL)
            tripodNameLabel.text = tripod.name
            tripodLvLabel.attributedText = tripod.lv.htmlToAttributedString(fontSize: 1, alignment: .LEFT)
            tripodEffectLabel.attributedText = tripod.description.htmlToAttributedString(fontSize: 3, alignment: .LEFT)
        } else {
            tripodNameLabel.attributedText = tripod.description.htmlToAttributedString(fontSize: 4, alignment: .LEFT)
            tripodNameLabel.snp.makeConstraints {
                $0.centerY.equalTo(tripodImageView)
            }
        }
    }
}
