//
//  UIViewController + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
