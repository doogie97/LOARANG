//
//  NetworkManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

protocol NetworkManagerable {
    func request()
}

struct NetworkManager: NetworkManagerable {
    func request() {
    private func urlRequest(_ requestable: Requestable) throws -> URLRequest {
        guard let url = URL(string: requestable.baseURL + requestable.path) else {
            throw APIError.urlError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestable.httpMethod.rawValue
        
        requestable.header.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestable.params, options: [])
        } catch {
            throw APIError.httpBodyError
        }
        
        return request
    }
}
