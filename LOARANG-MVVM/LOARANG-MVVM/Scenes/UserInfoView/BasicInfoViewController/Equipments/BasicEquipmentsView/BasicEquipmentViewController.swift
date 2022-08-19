//
//  BasicEquipmentViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class BasicEquipmentViewController: UIViewController {
    private let viewModel: BasicEquipmentViewModelable
    private let container: Container
    
    init(viewModel: BasicEquipmentViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let basicEquipmentView = BasicEquipmentView()
    
    override func loadView() {
        super.loadView()
        self.view = basicEquipmentView
    }
}
