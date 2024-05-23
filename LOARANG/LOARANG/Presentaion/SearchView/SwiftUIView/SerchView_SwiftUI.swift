//
//  SerchView_SwiftUI.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import SwiftUI
import Kingfisher

struct SerchView_SwiftUI: View {
    @EnvironmentObject var recentUserData: RecentUserData
    var body: some View {
        Text(recentUserData.recentUserList.first?.name ?? "")
        //        KFImage(URL(string: recentUserList.first?.imageUrl ?? ""))
        //            .resizable()
        //            .frame(width: 20, height: 20)
    }
}

#Preview {
    let recentUserData = RecentUserData(localRepository: LocalStorageRepository.forPreview)
    return SerchView_SwiftUI()
        .environmentObject(recentUserData)
}
