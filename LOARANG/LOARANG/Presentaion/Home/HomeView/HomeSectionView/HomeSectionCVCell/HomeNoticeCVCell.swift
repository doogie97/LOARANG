//
//  HomeNoticeCVCell.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit
import SnapKit

final class HomeNoticeCVCell: UICollectionViewCell {
    private lazy var tagLabel = {
        let label = pretendardLabel(size: 12, alignment: .center)
        label.backgroundColor = .mainBackground
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        
        return label
    }()
    private lazy var noticeTitleLabel = pretendardLabel(size: 16, family: .Regular)
    
    func setCellContents(noticeInfo: GameNoticeEntity?) {
        self.backgroundColor = .cellColor
        self.layer.cornerRadius = 6
        noticeTitleLabel.text = noticeInfo?.title
        setNoticeTag(noticeInfo?.type ?? .unknown)
        setLayout()
    }
    
    private func setNoticeTag(_ noticeType: GameNoticeEntity.NoticeType) {
        tagLabel.text = noticeType.rawValue
    }
    
    private func setLayout() {
        self.contentView.addSubview(tagLabel)
        self.contentView.addSubview(noticeTitleLabel)
        
        tagLabel.setContentHuggingPriority(.required, for: .horizontal)
        tagLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        tagLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(28)
            $0.width.equalTo(35)
            $0.leading.equalToSuperview().inset(margin(.width, 10))
        }
        
        noticeTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(tagLabel.snp.trailing).inset(margin(.width, -8))
            $0.trailing.equalToSuperview().inset(margin(.width, 16))
            $0.top.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
