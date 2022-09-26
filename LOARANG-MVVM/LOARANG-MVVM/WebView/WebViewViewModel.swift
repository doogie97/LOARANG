//
//  WebViewViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import Foundation

protocol WebViewViewModelable: WebViewViewModelInput, WebViewViewModelOutput {}

protocol WebViewViewModelInput {}

protocol WebViewViewModelOutput {
    var url: URLRequest { get }
    var title: String { get }
}

final class WebViewViewModel: WebViewViewModelable {
    init(url: URL, title: String) {
        self.url = URLRequest(url: url)
        self.title = title
    }
    
    //out
    let url: URLRequest
    let title: String
}
