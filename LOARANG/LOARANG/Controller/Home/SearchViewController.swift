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
                return "대표 캐릭터를 설정 하시겠습니까?"
            }
        }
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
            UserDefaults.standard.set(userName, forKey: "mainCharacter")
            NotificationCenter.default.post(name: Notification.Name.mainCharacter, object: nil)
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
    
    @IBAction func touchBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        myActivityIndicator.isHidden = false
        self.view.endEditing(true)
        guard let userName = searchBar.text else { return }

        do {
            let info = try CrawlManager.shared.searchUser(userName: userName)
            if self.vcType == .searchCharacter {
                moveToUserInfoVC(info: info)
            } else {
                showAlert(title: "\(info.basicInfo.name) LV.\(info.basicInfo.itemLevel)(\(info.basicInfo.class))", message: vcType.alertMessage, userName: userName)
            }
        } catch {
            showAlert(title: "", message: vcType.alertMessage, userName: nil)
        }
        
        myActivityIndicator.isHidden = true
    }
}
