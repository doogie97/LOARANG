//
//  SearchViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import Foundation
import RxRelay

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput {}

protocol SearchViewModelInput {
    func touchBackButton()
}

protocol SearchViewModelOutput {
    var popView: PublishRelay<Void> { get }
}

final class SearchViewModel: SearchViewModelable {
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    //out
    var popView = PublishRelay<Void>()
}
