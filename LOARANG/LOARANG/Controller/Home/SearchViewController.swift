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
    }
    
    private var vcType: VCType = .searchCharacter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSearchBar.delegate = self
    }
    
    func setVCType(type: VCType) {
        self.vcType = type
    }
    
    private func showAlert(title: String, message: String, userName: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let userName = userName else {
                return
            }
            self.setMainCharacter(userName: userName)
        }
        alert.addAction(yesAction)
        
        if userName != nil {
            let noAction = UIAlertAction(title: "취소", style: .destructive)
            alert.addAction(noAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    private func moveToUserInfoVC(info: UserInfo) {
        guard let userInfoVC = storyboard?.instantiateViewController(withIdentifier: "\(UserInfoViewController.self)") as? UserInfoViewController else { return }
        userInfoVC.receiveInfo(user: info)
        navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    private func setMainCharacter(userName: String) {
        UserDefaults.standard.set(userName, forKey: "mainCharacter")
        NotificationCenter.default.post(name: Notification.Name.mainCharacter, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        myActivityIndicator.isHidden = false
        self.view.endEditing(true)
        
        guard let userName = searchBar.text else {
            return
        }
        
        userName.crawlUser { info in
            switch info {
            case .success(let info):
                self.showUser(info)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func showUser(_ info: UserInfo) {
        if self.vcType == .searchCharacter {
            self.moveToUserInfoVC(info: info)
        } else {
            self.showAlert(title: "\(info.basicInfo.name) LV.\(info.basicInfo.itemLevel)(\(info.basicInfo.class))", message: "대표 캐릭터를 설정 하시겠습니까?", userName: info.basicInfo.name)
        }
        
        self.myActivityIndicator.isHidden = true
    }
    
    private func handleError(_ error: Error) {
        switch error {
        case CrawlError.inspection:
            self.showInspectionAlert()
        case CrawlError.searchError:
            print(error)
            self.showAlert(title: "", message: "검색하신 유저가 없습니다", userName: nil)
        default:
            self.showAlert(title: "", message: "알 수 없는 오류", userName: nil)
        }
        
        self.myActivityIndicator.isHidden = true
    }
}
