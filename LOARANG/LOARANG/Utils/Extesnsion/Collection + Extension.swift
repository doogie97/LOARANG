//
//  Collection + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/23.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
