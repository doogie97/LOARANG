//
//  WebViewViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import UIKit

final class WebViewViewController: UIViewController {
    private let viewModel: WebViewViewModelable
    
    init(viewModel: WebViewViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
