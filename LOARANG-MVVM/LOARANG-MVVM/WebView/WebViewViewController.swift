//
//  WebViewViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import RxSwift

final class WebViewViewController: UIViewController {
    private let viewModel: WebViewViewModelable
    
    init(viewModel: WebViewViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let webViewView = WebViewView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = webViewView
        webViewView.setViewContents(url: viewModel.url, title: viewModel.title)
        bindView()
    }
    
    private func bindView() {
        webViewView.backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBackButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.popView
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
