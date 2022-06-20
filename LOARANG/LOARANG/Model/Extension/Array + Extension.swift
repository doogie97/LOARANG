//
//  Array + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

extension Array {
    mutating func popFirst() -> Element? {
        if self.isEmpty {
            return nil
        } else {
            return self.removeFirst()
        }
    }
}
