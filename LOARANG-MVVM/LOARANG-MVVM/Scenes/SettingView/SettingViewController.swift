//
//  SettingViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit

final class SettingViewController: UIViewController {
    let viewModel: SettingViewModelable
    
    init(viewModel: SettingViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let settingView = SettingView()
    override func loadView() {
        super.loadView()
        self.view = settingView
        setTableView()
    }
    
    private func setTableView() {
        settingView.menuTableView.dataSource = self
        settingView.menuTableView.delegate = self
    }
}

extension SettingViewController: UITableViewDataSource {
    enum CellType: Int, CaseIterable {
        case changeMainUser = 0
        case notice = 1
        case suggestion = 2
        
        var title: String {
            switch self {
            case .changeMainUser:
                return "대표 캐릭터 변경"
            case .notice:
                return "공지 사항"
            case .suggestion:
                return "버그제보 및 건의"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SettingTVCell.self)", for: indexPath) as? SettingTVCell else {
            return UITableViewCell()
        }
        guard let title = CellType(rawValue: indexPath.row)?.title else {
            return UITableViewCell()
        }
        cell.setCellContents(title: title)
        
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == CellType.changeMainUser.rawValue {
            viewModel.touchChangeMainUserCell()
        }
    }
}
