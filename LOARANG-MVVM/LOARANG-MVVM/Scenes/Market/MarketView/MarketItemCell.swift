//
//  MarketItemCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/15.
//

import SnapKit

final class MarketItemCell: UITableViewCell {
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
        
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, tradeRemainCountLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 14, family: .Bold)
        
        return label
    }()
    
    private lazy var tradeRemainCountLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 12, family: .Bold)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var priceView = MarketItemPriceView()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .mainBackground
        
        contentView.addSubview(backView)
        
        backView.addSubview(itemImageView)
        backView.addSubview(titleStackView)
        backView.addSubview(priceView)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        itemImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(48)
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(16)
            $0.top.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(itemImageView.snp.centerY)
        }
        
        priceView.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setCellContents(_ item: MarketItems.Item) {
        _ = itemImageView.setImage(urlString: item.imageURL)
        itemImageView.backgroundColor = ItemGrade(rawValue: item.grade ?? "")?.backgroundColor
        nameLabel.text = item.name
        if let tradeRemainCount = item.tradeRemainCount {
            tradeRemainCountLabel.text = tradeRemainCount == 0 ? "구매시 거래 불가" : "구매시 거래 \(tradeRemainCount)회 가능"
        } else {
            tradeRemainCountLabel.text = "거래 제한 없음"
        }
        
        priceView.setPrice(minimum: item.minimumPrice,
                           yesterday: item.yesterDayAVGPrice,
                           recent: item.recentPrice)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemImageView.image = nil
        nameLabel.text = nil
        tradeRemainCountLabel.text = nil
    }
    
    enum ItemGrade: String {
        case nomal = "노말"
        case advanced = "희귀"
        case rare = "레어"
        case hero = "영웅"
        case legendary = "전설"
        case artifact = "유물"
        case ancient = "고대"
        case esther = "에스더"
        
        var backgroundColor: UIColor {
            switch self {
            case .nomal:
                return #colorLiteral(red: 0.593928329, green: 0.580765655, blue: 0.5510483948, alpha: 1)
            case .advanced:
                return #colorLiteral(red: 0.1626245975, green: 0.2453864515, blue: 0.06184400618, alpha: 1)
            case .rare:
                return #colorLiteral(red: 0.06879425794, green: 0.2269216776, blue: 0.347065717, alpha: 1)
            case .hero:
                return #colorLiteral(red: 0.2530562878, green: 0.06049384922, blue: 0.3300251961, alpha: 1)
            case .legendary:
                return #colorLiteral(red: 0.5773422718, green: 0.3460586369, blue: 0.01250262465, alpha: 1)
            case .artifact:
                return #colorLiteral(red: 0.4901602268, green: 0.2024044096, blue: 0.03712747619, alpha: 1)
            case .ancient:
                return #colorLiteral(red: 0.7324138284, green: 0.6683282852, blue: 0.5068081021, alpha: 1)
            case .esther:
                return #colorLiteral(red: 0.1549170911, green: 0.5648770332, blue: 0.55634588, alpha: 1)
            }
        }
    }
}
