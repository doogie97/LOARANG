//
//  CharacterDetailAvatarVC.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit

final class CharacterDetailAvatarVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    
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
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
    }
    
    private func setLayout() {
        self.view.backgroundColor = .cellBackgroundColor
    }
}
