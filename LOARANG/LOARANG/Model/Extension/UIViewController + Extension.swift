//
//  UIViewController + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/29.
//
import UIKit

extension UIViewController {
    func showInspectionAlert() {
        let alert = UIAlertController(title: "서버 점검", message: "서버 점검으로 인해 유저 검색 기능이 제한됩니다. \n자세한 사항은 로스트 아크 공식 홈페이지를 확인해 주세요", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
