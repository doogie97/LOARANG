//
//  APIError.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

enum APIError: Error {
    case responseError
    case statusCodeError(_ errorInfo: ErrorInfo)
    case timeOut
    case RateLimitExceeded
    case DecodingError
}

struct ErrorInfo {
    let message: String?
    let statusCode: Int
}

struct ErrorResponse: Decodable {
    let Message: String?
}
