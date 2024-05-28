//
//  ImageView.swift
//  LOARANG
//
//  Created by Doogie on 5/23/24.
//

import SwiftUI
import Kingfisher

struct ImageView: View {
    let imageUrl: String
    var body: some View {
        KFImage(URL(string: imageUrl))
            .resizable()
            .cacheMemoryOnly()
            .fade(duration: 0.2)
            .retry(maxCount: 3, interval: .seconds(3))
            .scaledToFit()
    }
}
