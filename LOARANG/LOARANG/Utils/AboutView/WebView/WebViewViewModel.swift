//
//  WebViewViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import Foundation
import RxRelay

protocol WebViewViewModelable: WebViewViewModelInput, WebViewViewModelOutput {}

protocol WebViewViewModelInput {
    func touchBackButton()
}

protocol WebViewViewModelOutput {
    var url: URLRequest { get }
    var title: String { get }
    var popView: PublishRelay<Void> { get }
}

final class WebViewViewModel: WebViewViewModelable {
    init(url: URL, title: String) {
        self.url = URLRequest(url: url)
        self.title = title
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    //out
    let url: URLRequest
    let title: String
    let popView = PublishRelay<Void>()
}
