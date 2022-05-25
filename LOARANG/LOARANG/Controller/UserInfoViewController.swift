//
//  UserInfoViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

class UserInfoViewController: UIViewController {
    @IBOutlet weak var userInfoTableView: UITableView!
    private var user: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoTableView.dataSource = self
        userInfoTableView.delegate = self
        userInfoTableView.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInfoTableViewCell")
    }
}

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell") as? UserInfoTableViewCell else { return UserInfoTableViewCell() }
        
        guard let user = user else { return cell }
 
        switch indexPath.row {
        case 0:
            cell.showInfo(info: user.name)
        case 1:
            cell.showInfo(info: user.expeditionLevel)
        case 2:
            cell.showInfo(info: user.battleLevel)
        case 3:
            cell.showInfo(info: user.itemLevel)
        case 4:
            cell.showInfo(info: user.title)
        case 5:
            cell.showInfo(info: user.guild)
        case 6:
            cell.showInfo(info: user.pvpGrade)
        default:
            cell.showInfo(info: user.wisdom)
        }
        
        return cell
    }
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.1
    }
}
