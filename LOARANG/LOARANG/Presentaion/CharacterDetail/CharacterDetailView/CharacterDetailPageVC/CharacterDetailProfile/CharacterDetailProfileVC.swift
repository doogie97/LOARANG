//
//  CharacterDetailProfileVC.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class CharacterDetailProfileVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    private let sectionView = CharacterDetailProfileSectionView()
    
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
        sectionView.setViewContents(viewModel: viewModel)
    }
    
    private func setLayout() {
        self.view.backgroundColor = .cellBackgroundColor
        self.view.addSubview(sectionView)
        
        sectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
