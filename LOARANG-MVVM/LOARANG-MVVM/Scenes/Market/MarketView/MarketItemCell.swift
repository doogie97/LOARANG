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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .one(size: 16, family: .Bold)
        label.backgroundColor = .red
        
        return label
    }()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .mainBackground
        
        contentView.addSubview(backView)
        
        backView.addSubview(itemImageView)
        backView.addSubview(nameLabel)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
        }
        
        itemImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(64)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(100)
            $0.top.trailing.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    func setCellContents(_ item: MarketItems.Item) {
        _ = itemImageView.setImage(urlString: item.imageURL)
        itemImageView.backgroundColor = ItemGrade(rawValue: item.grade ?? "")?.backgroundColor
        nameLabel.text = item.name
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
