//
//  PretendardText.swift
//  LOARANG
//
//  Created by Doogie on 5/28/24.
//

import SwiftUI

struct CustomText: View {
    enum Family: String {
        case Bold, Light, Regular, Black, SemiBold
    }
    
    enum Font {
        case one(family: Family)
        case BlackHanSans
        case pretendard(family: Family)
    }
    
    let text: String
    let font: Font
    let size: Double
    
    init(_ text: String, font: Font, size: Double) {
        self.text = text
        self.font = font
        self.size = size
    }
    
    var body: some View {
        var fontName: String {
            switch font {
            case .one(let family):
                return "ONEMobile\(family)"
            case .BlackHanSans:
                return "BlackHanSans-Regular"
            case .pretendard(let family):
                return "Pretendard-\(family)"
            }
        }
        Text(text)
            .font(.custom(fontName, size: size))
    }
}

#Preview {
    CustomText("hi", font: .BlackHanSans, size: 300)
}
