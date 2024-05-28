//
//  CropView.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import SwiftUI
import Kingfisher

struct CircleCropImage: View {
    struct Info {
        let imageUrl: String
        let characterClass: CharacterClass
        let sideLength: Double
    }
    
    let info: Info
    
    init(info: Info, sideLength: Double = 500) {
        self.info = info
    }
    
    var scale: Double {
        return info.sideLength / 500
    }
    
    var isSpecialList: Bool {
        info.characterClass == .aeromancer ||
        info.characterClass == .artist ||
        info.characterClass == .specialist
    }
    
    var body: some View {
        if info.imageUrl == "" {
            Image("unknownCharacterImg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.circle)
                .frame(width: info.sideLength,
                       height: info.sideLength)
        } else {
            circleImage
                .frame(width: info.sideLength,
                       height: info.sideLength)
                .scaleEffect(scale)
        }
    }
    
    var circleImage: some View {
        return ImageView(imageUrl: info.imageUrl)
            .frame(width: 500,
                   height: 500)
            .scaleEffect(isSpecialList ? 3.5 : 3)
            .offset(y: isSpecialList ? 200 : 370)
            .clipShape(.circle)
    }
}

#Preview {
    CircleCropImage(
        info: CircleCropImage.Info(
            imageUrl: "",
            characterClass: .specialist,
            sideLength: 200
        )
    )
}
