//
//  APIError.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

enum APIError: Error {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.responseError, .responseError):
            return true
        case (.statusCodeError, .statusCodeError):
            return true
        case (.timeOut, .timeOut):
            return true
        case (.RateLimitExceeded, .RateLimitExceeded):
            return true
        case (.DecodingError, .DecodingError):
            return true
        default:
            return false
        }
    }
    
    case responseError
    case statusCodeError(_ code: Int)
    case timeOut
    case RateLimitExceeded
    case DecodingError
}
