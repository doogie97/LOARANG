//
//  CollectionInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/05.
//

protocol CollectionInfoViewModelable: CollectionInfoViewModelInput, CollectionInfoViewModelOutput {}

protocol CollectionInfoViewModelInput {}

protocol CollectionInfoViewModelOutput {}

final class CollectionInfoViewModel: CollectionInfoViewModelable {}
