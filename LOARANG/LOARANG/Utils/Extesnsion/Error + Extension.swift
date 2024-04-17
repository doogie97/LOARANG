//
//  Error + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/15.
//

extension Error {
    var errorMessage: String {
        if let apiError = self as? APIError {
            switch apiError {
            case .responseError, .DecodingError:
                return "서버 통신 중 오류가 발생했습니다\n고객 센터를 통해 문의 부탁드립니다 (\(self))"
            case .statusCodeError(let statusCode):
                if statusCode == 503 {
                    return "로스트아크 서버가 점검중입니다.\n자세한 사항은 로스트아크 공식 홈페이지를 확인해 주세요!"
                } else {
                    return "서버 통신간 오류가 발생했습니다\nerrorCode: \(statusCode)"
                }
            case .timeOut:
                return "네트워크 연결이 원활하지 않습니다.\n잠시 후 다시 시도해 주세요."
            case .RateLimitExceeded:
                return "서버 요청 횟수를 초과하였습니다.\n1분 뒤 다시 시도해 주세요."
            }
        }
        
        if let localStorageErro = self as? LocalStorageError {
            return localStorageErro.errorDescrption
        }
        
        if let crawlError = self as? CrawlError {
            return crawlError.errorDescription
        }

        return "알 수 없는 오류가 발생했습니다\n고객 센터를 통해 문의 부탁드립니다"
    }
}
