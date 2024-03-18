//
//  APIError.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

enum APIError: Error {
    case urlError
    case httpBodyError
    case transportError
    case responseError
    case statusCodeError
    case dataError
    case unknownError
}
