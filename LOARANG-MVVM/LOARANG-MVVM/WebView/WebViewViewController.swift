//
//  WebViewViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import RxSwift
import WebKit

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
        setToolbar()
        bindView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = true
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
        
        goBackButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.webViewView.webView.goBack()
            })
            .disposed(by: disposeBag)
        
        goFowardButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.webViewView.webView.goForward()
            })
            .disposed(by: disposeBag)
        
        reloadButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.webViewView.webView.reload()
            })
            .disposed(by: disposeBag)
        
        shareButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let url = self?.webViewView.webView.url else {
                    return
                }
                let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self?.view
                
                self?.present(activityVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setToolbar() {
        navigationController?.isToolbarHidden = false
        webViewView.webView.navigationDelegate = self
        toolbarItems = [spacer,
                        goBackButton, spacer, spacer, spacer,
                        goFowardButton, spacer, spacer, spacer,
                        reloadButton, spacer, spacer, spacer,
                        shareButton, spacer]
    }
    
    private lazy var spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    private lazy var goBackButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "chevron.left")
        button.tintColor = .systemGray
        
        return button
    }()

    private lazy var goFowardButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "chevron.right")
        button.tintColor = .systemGray
        
        return button
    }()
    
    private lazy var reloadButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "arrow.counterclockwise")
        button.tintColor = .systemGray
        
        return button
    }()
    
    private lazy var shareButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "square.and.arrow.up")
        button.tintColor = .systemGray
        
        return button
    }()
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        goBackButton.isEnabled = webView.canGoBack
        goFowardButton.isEnabled = webView.canGoForward
    }
}
