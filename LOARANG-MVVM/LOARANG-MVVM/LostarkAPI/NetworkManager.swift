//
//  NetworkManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

protocol NetworkManagerable {
    func request<T: Decodable>(_ requestable: Requestable, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

struct NetworkManager: NetworkManagerable {
    func request<T: Decodable>(_ requestable: Requestable, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        do {
            let request = try urlRequest(requestable)
            
            AF.request(request).responseDecodable(of: resultType.self) { result in
                guard result.error == nil else {
                    completion(.failure(APIError.transportError))
                    return
                }
                
                guard let response = result.response else {
                    completion(.failure(APIError.responseError))
                    return
                }
                
                guard !(200...299).contains(response.statusCode) else {
                    completion(.failure(APIError.statusCodeError))
                    return
                }
                
                guard let value = result.value else {
                    completion(.failure(APIError.dataError))
                    return
                }
                
                completion(.success(value))
            }
        } catch let error {
            completion(.failure(error as? APIError ?? APIError.unknownError))
        }
    }
    
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
