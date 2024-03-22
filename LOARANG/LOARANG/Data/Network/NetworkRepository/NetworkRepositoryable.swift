//
//  NetworkRepositoryable.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

protocol NetworkRepositoryable {
    func getNews() async throws -> NewsAPIModel
    func getNotice
}
