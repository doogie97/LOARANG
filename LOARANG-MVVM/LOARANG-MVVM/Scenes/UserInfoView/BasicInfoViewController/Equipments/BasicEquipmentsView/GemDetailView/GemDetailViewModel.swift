//
//  GemDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

protocol GemDetailViewModelable: GemDetailViewModelInput, GemDetailViewModelOutput {}

protocol GemDetailViewModelInput {}

protocol GemDetailViewModelOutput {
    var gem: Gem { get }
}

final class GemDetailViewModel: GemDetailViewModelable {
    init(gem: Gem) {
        self.gem = gem
    }
    //in
    let gem: Gem
}
