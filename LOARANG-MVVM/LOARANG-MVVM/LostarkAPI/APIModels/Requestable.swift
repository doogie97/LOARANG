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
    var header: [String : String] { get }
    var params: [String : Any] { get }
    var httpMethod: HTTPMethod { get }
}
