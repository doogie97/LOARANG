//
//  SettingViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit

final class SettingViewController: UIViewController {
    private let settingView = SettingView()
    override func loadView() {
        super.loadView()
        self.view = settingView
    }
}
