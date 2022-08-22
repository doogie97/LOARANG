//
//  AvatarDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import UIKit

final class AvatarDetailViewController: UIViewController {
    private let viewModel: AvatarDetailViewModelable
    
    init(viewModel: AvatarDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let avatarDetailView = AvatarDetailView()
    
    override func loadView() {
        super.loadView()
        self.view = avatarDetailView
    }
}
