//
//  Error + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/15.
//

extension Error {
    var statusCode: Int? {
        guard let error = self as? APIError else {
            return nil
        }
        
        switch error {
        case .responseError(let statusCode):
            return statusCode
        default:
            return nil
        }
    }
    
    var limitErrorMessage: String? {
        if let statusCode = statusCode, statusCode == 429 {
            return "검색 요청 초과, 1분 뒤 다시 요청해주세요!\n지속적으로 오류 발생시 고객센터 문의 바랍니다\n(설정 - 버그 제보 및 건의)"
        }
        
        return nil
    }
    
    var errorMessage: String {
        if let localStorageErro = self as? LocalStorageError {
            return localStorageErro.errorDescrption
        }
        
        if let crawlError = self as? CrawlError {
            return crawlError.errorDescription
        }

        return "알 수 없는 오류가 발생했습니다\n고객 센터를 통해 문의 부탁드립니다"
    }
}
