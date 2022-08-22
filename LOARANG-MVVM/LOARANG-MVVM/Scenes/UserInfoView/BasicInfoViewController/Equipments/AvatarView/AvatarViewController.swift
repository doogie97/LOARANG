//
//  AvatarViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class AvatarViewController: UIViewController {
    private let avatarView = BasicEquipmentView()
    
    override func loadView() {
        self.view = avatarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
