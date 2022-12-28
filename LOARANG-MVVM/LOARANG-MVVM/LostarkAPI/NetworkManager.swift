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
        guard let status = response.response, (200...299).contains(status.statusCode) else {
            throw APIError.responseError(statusCode: response.response?.statusCode ?? 0)
        }
        
        switch response.result {
        case .success(let response):
            return response
        case .failure:
            throw APIError.transportError
        }
    }
}
