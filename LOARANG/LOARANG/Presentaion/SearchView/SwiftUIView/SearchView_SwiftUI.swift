//
//  SearchView_SwiftUI.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import SwiftUI
import Kingfisher

struct SearchView_SwiftUI: View {
    @EnvironmentObject var recentUserData: RecentUserData
    var body: some View {
        ZStack {
            Color(UIColor.mainBackground)
                .edgesIgnoringSafeArea(.all)
            listView
        }
    }
}

extension SearchView_SwiftUI {
    var listView: some View {
        List {
            ForEach(recentUserData.recentUserList, id: \.self) { user in
                let index = recentUserData.recentUserList.firstIndex(of: user) ?? 0
                RecentUserItemView(
                    isBookmark: $recentUserData.recentUserList[index].isBookmark,
                    recentUser: user
                )
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    )
                )
            }
        }
        .padding()
        .listStyle(.plain)
    }
}

#Preview {
    let recentUserData = RecentUserData(localRepository: LocalStorageRepository.forPreview)
    return SearchView_SwiftUI()
        .environmentObject(recentUserData)
}
