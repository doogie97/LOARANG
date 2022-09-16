//
//  OwnCharacterView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/16.
//

import SnapKit

final class OwnCharacterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .mainBackground
        tableView.separatorStyle = .none
        tableView.register(OwnCharacterCell.self)
        
        return tableView
    }()
    
    private func setLayout() {
        self.addSubview(charactersTableView)
        
        charactersTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
