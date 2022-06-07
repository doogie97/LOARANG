//
//  UserInfoViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

import UIKit

class UserInfoViewController: UIViewController {
    @IBOutlet weak var userInfoTableView: UITableView!
    private var user: BasicInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoTableView.dataSource = self
        userInfoTableView.delegate = self
        userInfoTableView.register(UINib(nibName: "\(BasicInfoTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(BasicInfoTVCell.self)")
    }
    
    func receiveInfo(user: BasicInfo) {
        self.user = user
    }
}

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BasicInfoTVCell.self)") as? BasicInfoTVCell else { return BasicInfoTVCell() }
        
        guard let user = user else { return cell }
        cell.configuerInfo(info: user)
        
        return cell
    }
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.45
    }
}
