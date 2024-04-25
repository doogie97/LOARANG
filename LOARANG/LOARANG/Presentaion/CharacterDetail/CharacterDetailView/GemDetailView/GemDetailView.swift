//
//  GemDetailView.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit

final class GemDetailView: UIView {
    private var gems = [CharacterDetailEntity.Gem]()
    private lazy var gemListTV = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(GemDetailCell.self)
        tableView.dataSource = self
        
        return tableView
    }()
    
    func setViewContents(gems: [CharacterDetailEntity.Gem]) {
        self.backgroundColor = .cellBackgroundColor
        self.gems = gems
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(gemListTV)
        gemListTV.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 2 / 3)
        }
    }
}

extension GemDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GemDetailCell.self)", for: indexPath) as? GemDetailCell,
              let gem = gems[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellContents(gem: gem)
        return cell
    }
}
