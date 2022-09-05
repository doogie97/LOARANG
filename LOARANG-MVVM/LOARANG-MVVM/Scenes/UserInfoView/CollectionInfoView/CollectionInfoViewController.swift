//
//  CollectionInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit

final class CollectionInfoViewController: UIViewController {
    private let viewModel: CollectionInfoViewModelable
    
    init(CollectionInfoViewModel: CollectionInfoViewModelable) {
        self.viewModel = CollectionInfoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionInfoView = CollectionInfoView()
    
    override func loadView() {
        super.loadView()
        self.view = collectionInfoView
    }

}
