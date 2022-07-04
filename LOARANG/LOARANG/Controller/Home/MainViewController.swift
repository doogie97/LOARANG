//
//  MainViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var mainTableView: UITableView!
    @IBOutlet private weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitailStatus()
    }
    
    private func setInitailStatus() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
        mainTableView.register(UINib(nibName: "\(BookMarkTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(BookMarkTVCell.self)")
        mainTableView.register(UINib(nibName: "\(MianUserTVCell.self)", bundle: nil), forCellReuseIdentifier: "\(MianUserTVCell.self)")
        BookmarkManager.shared.setUsers()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name.mainCharacter, object: nil)
        
        do {
            try CrawlManager.shared.checkInspection()
        } catch {
            showInspectionAlert()
        }
    }
    
    @objc private func reloadTV() {
        mainTableView.reloadData()
    }
    
    @objc private func touchMainUserCell() {
        guard let userName = UserDefaults.standard.string(forKey: "mainCharacter") else { return }
        moveToUserInfoVC(name: userName)
    }
    
    @IBAction private func touchSearchButton(_ sender: UIButton) {
        guard let searchVC = storyboard?.instantiateViewController(withIdentifier: "\(SearchViewController.self)") as? SearchViewController else { return }
        searchVC.setVCType(type: .searchCharacter)
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MianUserTVCell.self)") as? MianUserTVCell else { return MianUserTVCell()}
            cell.setCell()
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchMainUserCell))
            cell.addGestureRecognizer(tapGestureRecognizer)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookMarkTVCell.self)") as? BookMarkTVCell else { return BookMarkTVCell()}
            cell.setTVCell(vc: self)
            return cell
        default:
            return BookMarkTVCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.width * 0.75
        }
        return UIScreen.main.bounds.width * 0.58
    }
}

extension MainViewController: TouchCellDelegate {
    func moveToUserInfoVC(name: String) {
        name.crawlUser { info in
            switch info {
            case .success(let info):
                self.showUser(info)
            case .failure(_):
                //일단은 점검 오류 얼럿 표시, 추후 에러에 따를 추가 필요
                self.showInspectionAlert()
            }
        }
    }
    
    private func showUser(_ info: UserInfo) {
        guard let userInfoVC = storyboard?.instantiateViewController(withIdentifier: "\(UserInfoViewController.self)") as? UserInfoViewController else { return }
        
        userInfoVC.receiveInfo(user: info)
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
}
