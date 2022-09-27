//
//  NoticeView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/27.
//

import SnapKit

final class NoticeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackgroundColor
        
        return view
    }()
    
    private lazy var noticeTitle: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        label.font = UIFont.BlackHanSans(size: 20)
        label.textColor = .buttonColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private(set) lazy var moreNoticeButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = UIFont.one(size: 13, family: .Bold)
        
        return button
    }()
    
    private(set) lazy var noticeTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private func setLayout() {
        self.backgroundColor = .tableViewColor
        self.addSubview(backView)
        
        backView.addSubview(noticeTitle)
        backView.addSubview(moreNoticeButton)
        backView.addSubview(noticeTableView)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        noticeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        moreNoticeButton.snp.makeConstraints {
            $0.centerY.equalTo(noticeTitle)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        noticeTableView.snp.makeConstraints {
            $0.top.equalTo(noticeTitle.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
