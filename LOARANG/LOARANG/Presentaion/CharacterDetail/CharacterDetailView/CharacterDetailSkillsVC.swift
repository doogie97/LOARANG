//
//  CharacterDetailSkillsVC.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class CharacterDetailSkillsVC: UIViewController {
    private weak var viewModel: CharacterDetailVMable?
    private var character: CharacterDetailEntity?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setViewContents(viewContents: CharacterDetailVM.ViewContents) {
        self.viewModel = viewContents.viewModel
        self.character = viewContents.character
    }
    
    private func setLayout() {
        self.view.backgroundColor = .systemOrange
        guard let character = self.character else {
            return
        }
    }
}
