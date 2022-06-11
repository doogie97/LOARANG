//
//  SearchViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    enum VCType {
        case searchCharacter
        case settingMainCharacter
        
        var alertMessage: String {
            switch self {
            case .searchCharacter:
                return "검색하신 유저가 없습니다"
            case .settingMainCharacter:
                return "해당 캐릭터로 태표 캐릭터를 설정 하시겠습니까?"
            }
        }
    }
    
    private var vcType: VCType = .searchCharacter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSearchBar.delegate = self
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "", message: "검색하신 유저가 없습니다", preferredStyle: .alert)
    func setVCType(type: VCType) {
        self.vcType = type
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
        myActivityIndicator.isHidden = false
        self.view.endEditing(true)
        guard let userName = searchBar.text else { return }
        guard let userInfoVC = storyboard?.instantiateViewController(withIdentifier: "\(UserInfoViewController.self)") as? UserInfoViewController else { return }
        do {
            let info = try CrawlManager.shared.searchUser(userName: userName)
            userInfoVC.receiveInfo(user: info)
        } catch {
            showAlert()
        }
        navigationController?.pushViewController(userInfoVC, animated: true)
        myActivityIndicator.isHidden = true
    }
}
