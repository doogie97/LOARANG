//
//  UserInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import UIKit

final class UserInfoViewController: UIViewController {
    private let viewModel: UserInfoViewModelable
    
    init(viewModel: UserInfoViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let userInfoView = UserInfoView()
    
    override func loadView() {
        super.loadView()
        self.view = userInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.userInfo.basicInfo.name)
    }
}
