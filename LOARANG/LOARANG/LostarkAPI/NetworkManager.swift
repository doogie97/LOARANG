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
}
