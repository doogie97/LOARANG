//
//  NetworkManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

protocol NetworkManagerable {
    func request<T: Decodable>(_ requestable: Requestable, resultType: T.Type) async throws -> T
}

struct NetworkManager: NetworkManagerable {
    func request<T: Decodable>(_ requestable: Requestable, resultType: T.Type) async throws -> T {
        let keys = Bundle.main.lostarkApiKeyArray.shuffled()
        for key in keys {
            do {
                let requestable = modifiedRequestable(requestable: requestable, apiKey: key)
                return try await innerRequest(requestable, resultType: resultType)
            } catch let error {
                if let error = processError(error) {
                    throw error
                }
            }
        }
        throw APIError.RateLimitExceeded
    }
    
    private func innerRequest<T: Decodable>(_ requestable: Requestable, resultType: T.Type) async throws -> T {
        let response = await requestable.dataTask(resultType: resultType).response
        
        switch response.error {
        case .sessionTaskFailed(_):
            throw APIError.timeOut
        default:
            break
        }
        
        guard let status = response.response else {
            throw APIError.responseError
        }
        
        guard (200...299).contains(status.statusCode) else {
            
            do {
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data ?? Data())
                throw APIError.statusCodeError(ErrorInfo(message: errorResponse.Message,
                                                         statusCode: status.statusCode))
            } catch let error {
                throw error
            }
        }
        
        switch response.result {
        case .success(let response):
            return response
        case .failure(let error):
            print(error)
            throw error
        }
    }
    
    private func modifiedRequestable(requestable: Requestable, apiKey: String) -> Requestable {
        var newHeader = requestable.header
        newHeader["authorization"] = "Bearer \(apiKey)"
        return ModifiedRequestable(baseURL: requestable.baseURL,
                                   path: requestable.path,
                                   header: newHeader,
                                   params: requestable.params,
                                   httpMethod: requestable.httpMethod,
                                   encodingType: requestable.encodingType)
    }
    
    private func processError(_ error: Error) -> Error? {
        if let apiError = error as? APIError {
            switch apiError {
            case .statusCodeError(let errorInfo):
                if errorInfo.statusCode == 429 {
                    return nil
                } else {
                    return error
                }
            case .timeOut, .responseError, .RateLimitExceeded:
                return error
            }
        }
        
        return error
    }
}

struct ModifiedRequestable: Requestable {
    let baseURL: String
    let path: String
    let header: [String : String]
    let params: [String : Any]
    let httpMethod: Alamofire.HTTPMethod
    let encodingType: EncodingType
}
