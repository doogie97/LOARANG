//
//  LocalStorageError.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/03.
//

enum LocalStorageError: Error {
    case addBookmarkError
    case updateBookmarkError
    case deleteBookmarkError
    case changeMainUserError
    case addRecentUserError
    case deleteRecentUserError
    
    var errorDescrption: String {
        switch self {
        case .addBookmarkError:
            return "북마크에 실패하였습니다.\n잠시 후 다시 시도해 주세요"
        case .updateBookmarkError:
            return "유저 갱신에 실패하였습니다.\n잠시 후 다시 시도해 주세요"
        case .deleteBookmarkError:
            return "북마크 제거에 실패하였습니다.\n잠시 후 다시 시도해 주세요"
        case .changeMainUserError:
            return "대표캐릭터 변경에 실패하였습니다.\n잠시 후 다시 시도해 주세요"
        default:
            return "최근 검색 목록을 불러오는데 실패하였습니다.\n잠시 후 다시 시도해 주세요"
        }
    }
}
