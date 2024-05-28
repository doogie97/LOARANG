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
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 16) {
                image
                CustomText(recentUser.name,
                           font: .one(family: .Bold),
                           size: 16)
                Spacer()
                starButton
            }
            Spacer(minLength: 0)
            Divider()
        }
    }
    
    var image: some View {
        CircleCropImage(
            info: CircleCropImage.Info(
                imageUrl: recentUser.imageUrl,
                characterClass: recentUser.characterClass,
                sideLength: 40
            )
        )
    }
    
    var starButton: some View {
        Button {
            isBookmark.toggle()
        } label: {
            Image(systemName: isBookmark ? "star.fill" : "star")
                .foregroundStyle(isBookmark ? Color("mainPink") : .white)
        }
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
