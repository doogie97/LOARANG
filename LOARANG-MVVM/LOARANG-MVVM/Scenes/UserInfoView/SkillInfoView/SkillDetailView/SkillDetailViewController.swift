//
//  SkillDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import UIKit

final class SkillDetailViewController: UIViewController {
    private let viewModel: SkillDetailViewModelable
    
    init(viewModel: SkillDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let skillDetailView = SkillDetailView()
    
    override func loadView() {
        super.loadView()
        self.view = skillDetailView
    }
    
    override func viewDidLoad() {
        skillDetailView.setViewContents(viewModel.skill)
    }
}
