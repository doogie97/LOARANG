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
        ZStack {
            Color(UIColor.mainBackground)
                .edgesIgnoringSafeArea(.all)
            List {
                ForEach(recentUserData.recentUserList, id: \.self) { user in
                    let index = recentUserData.recentUserList.firstIndex(of: user) ?? 0
                    RecentUserItemView(
                        isBookmark: $recentUserData.recentUserList[index].isBookmark,
                        recentUser: user
                    )
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    let recentUserData = RecentUserData(localRepository: LocalStorageRepository.forPreview)
    return SerchView_SwiftUI()
        .environmentObject(recentUserData)
}
