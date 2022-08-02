//
//  LocalStorageError.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/03.
//

enum LocalStorageError: Error {
    case addError
    case updateError
    case deleteError
    case changeMainUserError
    
    var errorDescrption: String {
        switch self {
        case .addError:
            return "북마크에 실패하였습니다. 잠시 후 다시 시도해 주세요"
        case .updateError:
            return "유저 갱신에 실패하였습니다. 잠시 후 다시 시도해 주세요"
        case .deleteError:
            return "북마크 제거에 실패하였습니다. 잠시 후 다시 시도해 주세요"
        case .changeMainUserError:
            return "대표캐릭터 변경에 실패하였습니다. 잠시 후 다시 시도해 주세요"
        }
    }
}
