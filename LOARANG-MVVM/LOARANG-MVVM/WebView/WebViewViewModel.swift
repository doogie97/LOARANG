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
    var url: URL { get }
}

final class WebViewViewModel: WebViewViewModelable {
    init(url: URL) {
        self.url = url
    }
    
    //out
    let url: URL
}
