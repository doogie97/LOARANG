//
//  SettingViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/09.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet private weak var settingTableView: UITableView!
    
    private enum Menu: Int, CaseIterable {
        case mainCharacter = 0
        case notice
        
        var title: String {
            switch self {
            case .mainCharacter:
                return "대표 캐릭터 설정"
            case .notice:
                return "공지사항"
            }
        }
    
        func move(stryboard:UIStoryboard? ,navigation: UINavigationController?) {
            switch self {
            case .mainCharacter:
                guard let searchVC = stryboard?.instantiateViewController(withIdentifier: "\(SearchViewController.self)") as? SearchViewController else { return }
                searchVC.setVCType(type: .settingMainCharacter)
                navigation?.pushViewController(searchVC, animated: true)
            case .notice:
                print(self.title)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registCell()
    }
    
    private func registCell() {
        settingTableView.register(UINib(nibName: "\(SettingTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(SettingTVCell.self)")
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }
}

extension SettingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Menu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SettingTVCell.self)", for: indexPath) as? SettingTVCell else { return SettingTVCell() }
        guard let menu = Menu(rawValue: indexPath.row) else { return SettingTVCell() }
        cell.configureCell(title: menu.title)
        return cell
    }
}

extension SettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menu = Menu(rawValue: indexPath.row) else { return }
        menu.move(stryboard: storyboard, navigation: navigationController)
    }
}
