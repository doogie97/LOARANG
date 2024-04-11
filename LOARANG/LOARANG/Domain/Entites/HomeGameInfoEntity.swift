//
//  HomeGameInfoEntity.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

struct HomeGameInfoEntity {
    let eventList: [Event]
    let noticeList: [GameNoticeEntity]
}

struct Event {
    let title: String
    let thumbnailImgUrl: String
    let url: String
    let startDate: String
    let endDate: String
    let rewardDate: String
}

struct GameNoticeEntity {
    let title: String
    let url: String
    let type: NoticeType
    enum NoticeType: String {
        case 공지
        case 점검
        case 상점
        case 이벤트
        case unknown
    }
}
