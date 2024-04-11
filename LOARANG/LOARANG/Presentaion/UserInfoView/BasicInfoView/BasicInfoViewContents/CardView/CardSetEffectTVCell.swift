//
//  CardSetEffectTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/04.
//

import UIKit
import SnapKit

final class CardSetEffectTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .one(size: 15, family: .Bold)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.7529411765, blue: 0.5058823529, alpha: 1)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .one(size: 15, family: .Bold)
        
        return label
    }()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellColor
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    func setCellContents(cardSetEffect: CardSetEffect) {
        setLayout()
        
        titleLabel.text = cardSetEffect.title
        descriptionLabel.text = "• " + cardSetEffect.description
    }
}
