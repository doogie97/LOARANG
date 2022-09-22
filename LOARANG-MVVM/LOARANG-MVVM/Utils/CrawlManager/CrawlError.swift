//
//  CrawlError.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

enum CrawlError: Error {
    case searchError
    case urlError
    case documentError
    case jsonInfoError
    case inspection
    case ownCharacterErrror
    
    var errorDescription: String {
        switch self {
        case .searchError:
            return "검색하신 유저가 없습니다"
        default:
            return "유저 검색 중 오류가 발생했습니다\n(Error code: \(self))"
        }
    }
}
