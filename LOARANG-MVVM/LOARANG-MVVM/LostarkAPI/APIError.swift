//
//  APIError.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

enum APIError: Error {
    case transportError
    case responseError(statusCode: Int)
}
