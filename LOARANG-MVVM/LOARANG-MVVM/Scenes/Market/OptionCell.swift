//
//  OptionCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import SnapKit

final class OptionCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var optionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.one(size: 14, family: .Bold)
        
        return label
    }()
    
    private lazy var selectedIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        imageView.isHidden = true
        
        return imageView
    }()
    
    private func setLayout() {
        self.backgroundColor = .clear
        self.contentView.addSubview(optionTitleLabel)
        self.contentView.addSubview(selectedIndicator)
        
        
        optionTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        selectedIndicator.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(15)
        }
    }
    
    func setCellContents(optionTitle: String) {
        optionTitleLabel.text = optionTitle
    }
    
    func setSelectedCell() {
        optionTitleLabel.textColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        selectedIndicator.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        optionTitleLabel.textColor = .label
        selectedIndicator.isHidden = true
    }
}
