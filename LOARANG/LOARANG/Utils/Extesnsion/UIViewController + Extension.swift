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
    
    func showSetMainCharacterAlert(action: ((String) -> Void)? = nil) {
        let alert = UIAlertController(title: "", message: "대표 캐릭터로 설정할 캐릭터를 입력해 주세요", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let action = action else {
                return
            }
            action(alert.textFields?[safe: 0]?.text ?? "")
        }
        
        let noAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        alert.addTextField()
        
        self.present(alert, animated: true)
    }
    
    func showCheckUserAlert(_ character: CharacterDetailEntity, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "\(character.profile.characterName) Lv.\(character.profile.itemLevel)(\(character.profile.characterClass.rawValue))",
                                      message: "대표 캐릭터를 설정 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let action = action else {
                return
            }
            
            action()
        }
        let noAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true)
    }
    
    //추 후 삭제 필요
    func showCheckUserAlert(_ mainUser: MainUserEntity, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "\(mainUser.name) Lv.\(mainUser.itemLV)(\(mainUser.characterClass.rawValue))",
                                      message: "대표 캐릭터를 설정 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let action = action else {
                return
            }
            
            action()
        }
        let noAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
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
//MARK: - Keyboard toolbar
extension UIViewController {
    func closeKeyboardToolbar() -> UIToolbar {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(closeKeyboard))
        closeButton.tintColor = .systemGray
        
        let items = [flexSpace, closeButton]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }
    
    @objc private func closeKeyboard(){
        self.view.endEditing(true)
    }
}
