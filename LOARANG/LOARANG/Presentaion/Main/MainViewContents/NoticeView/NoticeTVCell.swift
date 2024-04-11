//
//  NoticeTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/27.
//

import UIKit
import SnapKit

final class NoticeTVCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var noticeTitleLabel: PaddingLabel = {
        let label = PaddingLabel(top: 16, bottom: 16, left: 16, right: 16)
        label.backgroundColor = #colorLiteral(red: 0.1797778045, green: 0.1801793545, blue: 0.2213729013, alpha: 1)
        label.font = UIFont.one(size: 15, family: .Bold)
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .mainBackground
        self.contentView.addSubview(noticeTitleLabel)
        
        noticeTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(2)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setCellContents(notice: LostArkNotice) {
        noticeTitleLabel.text = notice.title
    }
}
