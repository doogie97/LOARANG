//
//  UserInfoViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

class UserInfoViewController: UIViewController {
    @IBOutlet weak var userInfoTableView: UITableView!
    private var user: UserBasicInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoTableView.dataSource = self
        userInfoTableView.delegate = self
        userInfoTableView.register(UINib(nibName: "\(UserInfoTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(UserInfoTableViewCell.self)")
    }
    
    func receiveInfo(user: UserBasicInfo?) {
        self.user = user
    }
}

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserInfoTableViewCell.self)") as? UserInfoTableViewCell else { return UserInfoTableViewCell() }
        
        guard let user = user else { return cell }
 
        switch indexPath.row {
        case 0:
            cell.showInfo(info: user.name)
        case 1:
            cell.showInfo(info: "서버 : " + user.server)
        case 2:
            cell.showInfo(info: "클래스 : " + user.class)
        case 3:
            cell.showInfo(info: "원정대 : " + user.expeditionLevel)
        case 4:
            cell.showInfo(info: "전투 : " + user.battleLevel)
        case 5:
            cell.showInfo(info: "칭호 : " + user.title)
        case 6:
            cell.showInfo(info: "아이템 : " + user.itemLevel)
        case 7:
            cell.showInfo(info: "길드 : " + user.guild)
        case 8:
            cell.showInfo(info: "PVP : " + user.pvp)
        default:
            cell.showInfo(info: "영지 : " + user.wisdom)
        }
        
        return cell
    }
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.1
    }
}
