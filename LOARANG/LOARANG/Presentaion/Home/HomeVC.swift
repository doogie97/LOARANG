//
//  HomeVC.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import UIKit

final class HomeVC: UIViewController {
    private let container: Containerable
    private let viewModel: HomeVMable
    private let homeView = HomeView()
    
    init(container: Containerable,
         viewModel: HomeVMable) {
        self.container = container
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.setViewContents() //임시 호출
    }
}
