//
//  CropView.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import SwiftUI
import Kingfisher

///기본 frame 가로 세로 각 450
struct CharacterCropImage: View {
    enum CropCase {
        case circle
        case topSqure
    }
    struct Info {
        let imageUrl: String
        let characterClass: CharacterClass
        let cropCase: CropCase
    }
    let info: Info
    
    var body: some View {
        switch info.cropCase {
        case .circle:
            if info.characterClass == .aeromancer ||
                info.characterClass == .artist ||
                info.characterClass == .specialist {
                ImageView(imageUrl: info.imageUrl)
                    .frame(width: 450,
                           height: 450)
                    .scaleEffect(3.5)
                    .offset(y: 180)
                    .clipShape(.circle)
            } else {
                ImageView(imageUrl: info.imageUrl)
                    .frame(width: 450,
                           height: 450)
                    .scaleEffect(3)
                    .offset(y: 340)
                    .clipShape(.circle)
            }
                
        case .topSqure: //추후 캐릭터 상세 구현시 재 작성 예정
            ImageView(imageUrl: info.imageUrl)
                .clipShape(.circle)
        }
        
    }
}

#Preview {
    CharacterCropImage(
        info: CharacterCropImage.Info(
            imageUrl: "https://img.lostark.co.kr/armory/7/c099600e3be48afc300f44101a83e9a093202f6720a3a4025db35cf09fa18afe.png?v=20240324044337",
            characterClass: .blade,
            cropCase: .circle
        )
    )
    .scaleEffect(0.5)
}
