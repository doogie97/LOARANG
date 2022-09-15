//
//  UIViewController + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = "", message: String?, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let action = action else {
                return
            }
            action()
        })
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func showExitAlert(title: String = "", message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            exit(0)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
