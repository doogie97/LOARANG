//
//  UIViewController + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title , message: message ?? "알 수 없는 오류가 발생하였습니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
