//
//  HomeInfoEntity.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

struct HomeInfoEntity {
    let eventList: [Event]
    
    struct Event {
        let title: String
        let thumbnailImgUrl: String
        let url: String
        let startDate: String
        let endDate: String
        let rewardDate: String
    }
}
