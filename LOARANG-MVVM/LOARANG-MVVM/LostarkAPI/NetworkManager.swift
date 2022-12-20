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
        let dataTask = requestable.dataTask(resultType: resultType)
        
        switch await dataTask.result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
