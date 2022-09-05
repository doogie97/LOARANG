//
//  CollectionInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/05.
//

protocol CollectionInfoViewModelable: CollectionInfoViewModelInput, CollectionInfoViewModelOutput {}

protocol CollectionInfoViewModelInput {
    func touchSegmentControl(_ index: Int)
}

protocol CollectionInfoViewModelOutput {}

final class CollectionInfoViewModel: CollectionInfoViewModelable {
    //in
    func touchSegmentControl(_ index: Int) {
        print(index)
    }
    
}
