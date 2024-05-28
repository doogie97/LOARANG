//
//  RecentUserItemView.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import SwiftUI
import Kingfisher

struct RecentUserItemView: View {
    @Binding var isBookmark: Bool
    let recentUser: RecentUserEntity
    var body: some View {
        HStack {
            image
            Text("이름 : \(recentUser.name)")
            //            Divider()
            //            Text(isBookmark ? "북마크" : "아님")
            //            Spacer()
            //            Button {
//                isBookmark.toggle()
//            } label: {
//                Text("버튼")
//            }
        }
    }
    
    var image: some View {
        CircleCropImage(
            info: CircleCropImage.Info(
                imageUrl: recentUser.imageUrl,
                characterClass: recentUser.characterClass,
                sideLength: 50
            )
        )
    }
}

#Preview {
    let recentUserData = RecentUserData(localRepository: LocalStorageRepository.forPreview)
    return RecentUserItemView(
        isBookmark: .constant(true),
        recentUser: RecentUserEntity.forPreview
    )
    .frame(height: 50)
    .background(Color.init(uiColor: .mainBackground))
}
