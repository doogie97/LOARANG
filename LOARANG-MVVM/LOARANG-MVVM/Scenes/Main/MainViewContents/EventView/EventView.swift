//
//  EventView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import SnapKit

final class EventView: UIView {
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
    
    private lazy var eventTitle: UILabel = {
        let label = UILabel()
        label.text = "이벤트"
        label.font = UIFont.BlackHanSans(size: 20)
        label.textColor = .buttonColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private func setLayout() {
        self.backgroundColor = .tableViewColor
        self.addSubview(backView)
        
        backView.addSubview(eventTitle)
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        eventTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
