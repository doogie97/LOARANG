//
//  UserInfoViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

class UserInfoViewController: UIViewController {
    @IBOutlet private weak var userInfoTableView: UITableView!
    @IBOutlet private weak var navigationTitle: UINavigationItem!
    private var user: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
    }
    
    func receiveInfo(user: UserInfo) {
        self.user = user
    }

    @IBAction private func touchBackButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setInitialView() {
        navigationTitle.title = user?.basicInfo.name
        userInfoTableView.dataSource = self
        userInfoTableView.delegate = self
        userInfoTableView.register(UINib(nibName: "\(BasicInfoTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(BasicInfoTVCell.self)")
        userInfoTableView.register(UINib(nibName: "\(InfoCollectionViewTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(InfoCollectionViewTVCell.self)")
    }
}

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = user else { return BasicInfoTVCell() }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BasicInfoTVCell.self)") as? BasicInfoTVCell else { return BasicInfoTVCell() }
            
            cell.receiveUserInfo(info: user.basicInfo)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BasicAbilityTVCell.self)") as? BasicAbilityTVCell else { return BasicAbilityTVCell() }
            cell.configureInfo(info: user.basicAbility)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(InfoPageViewTVCell.self)") as? InfoPageViewTVCell else { return BasicAbilityTVCell() }
            cell.setInitailView()
            return cell
        default:
            return BasicInfoTVCell()
        }
    }
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.width * 0.45
        case 1:
            return UIScreen.main.bounds.width * 0.5
        default:
            return UIScreen.main.bounds.width * 1
        }
    }
}
