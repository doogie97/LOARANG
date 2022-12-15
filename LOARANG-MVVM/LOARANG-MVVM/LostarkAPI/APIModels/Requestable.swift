//
//  Requestable.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Alamofire

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String : String] { get }
    var params: [String : Any] { get }
    var httpMethod: HTTPMethod { get }
    var encodingType: EncodingType { get }
}

extension Requestable {
    var request: DataRequest {
        return AF.request(self.baseURL + self.path,
                          method: self.httpMethod,
                          parameters: self.params,
                          encoding: self.encodingType.parameterEncoding,
                          headers: HTTPHeaders(self.headers))
    }
}

enum Host {
    case lostarkAPI
    
    var baseURL: String {
        switch self {
        case .lostarkAPI:
            return "https://developer-lostark.game.onstove.com"
        }
    }
}

enum EncodingType {
    case jsonEncoding
    case urlEncoding
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .jsonEncoding:
            return JSONEncoding.default
        case .urlEncoding:
            return URLEncoding.default
        }
    }
}
