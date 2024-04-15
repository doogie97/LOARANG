//
//  GameNoticeEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

struct GameNoticeEntity {
    let title: String
    let url: String
    let type: NoticeType
    enum NoticeType: String {
        case 공지
        case 점검
        case 상점
        case 이벤트
        case unknown = "알 수 없음"
    }
}
