//
//  SearchViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var userSearchBar: UISearchBar!
    private let crawlManager = CrawlManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSearchBar.delegate = self
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "", message: "검색하신 유저가 없습니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func touchBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        guard let userName = searchBar.text else { return }
        guard let userInfoVC = storyboard?.instantiateViewController(withIdentifier: "\(UserInfoViewController.self)") as? UserInfoViewController else { return }
        do {
            let info = try crawlManager.searchUser(userName: userName)
            userInfoVC.receiveInfo(user: info.basicInfo)
        } catch {
            showAlert()
        }
        navigationController?.pushViewController(userInfoVC, animated: true)
    }
}
