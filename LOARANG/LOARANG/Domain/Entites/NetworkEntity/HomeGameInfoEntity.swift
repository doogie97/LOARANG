//
//  HomeGameInfoEntity.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

import Foundation

struct HomeGameInfoEntity {
    let appStoreVesion: String
    var currentVersion: String {
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return currentVersion ?? ""
    }
    let eventList: [GameEventEntity]
    let noticeList: [GameNoticeEntity]
    let challengeAbyssDungeonEntity: [ChallengeAbyssDungeonEntity]
    let challengeGuardianRaidsEntity: [ChallengeGuardianRaidEntity]
}
