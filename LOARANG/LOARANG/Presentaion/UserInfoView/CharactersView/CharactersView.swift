//
//  CharactersView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/16.
//

import UIKit
import SnapKit

final class CharactersView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var charactersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .mainBackground
        tableView.separatorStyle = .none
        tableView.register(OwnCharacterCell.self)
        
        return tableView
    }()
    
    private(set) var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.stopAnimating()
        
        return indicator
    }()
    
    private func setLayout() {
        self.addSubview(charactersTableView)
        self.addSubview(activityIndicator)
        
        charactersTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(charactersTableView)
        }
    }
}
