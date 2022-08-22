//
//  AvatarViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class AvatarViewController: UIViewController {
    private let viewModel: AvatarViewModelable
    private let container: Container
    
    init(viewModel: AvatarViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let avatarView = AvatarView()
    
    override func loadView() {
        self.view = avatarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
