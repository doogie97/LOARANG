//
//  SkillInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit

final class SkillInfoViewController: UIViewController {
    private let viewModel: SkillInfoViewModelable
    
    init(viewModel: SkillInfoViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let skillInfoView = SkillInfoView()
    
    override func loadView() {
        super.loadView()
        self.view = skillInfoView
    }
}
