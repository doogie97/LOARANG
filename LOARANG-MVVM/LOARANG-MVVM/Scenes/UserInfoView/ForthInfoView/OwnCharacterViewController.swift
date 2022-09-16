//
//  OwnCharacterViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit

final class OwnCharacterViewController: UIViewController {
    private let ownCharacterView = OwnCharacterView()
    
    override func loadView() {
        self.view = ownCharacterView
    }
}
