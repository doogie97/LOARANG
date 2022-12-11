//
//  NewsAPIModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Alamofire

struct NewsAPIModel: Requestable {
    var baseURL = Host.lostarkAPI.baseURL
    var path = "/news/events"
    var header: [String : String] = [:]
    var params: [String : Any] = [:]
    var httpMethod = HTTPMethod.get
}
