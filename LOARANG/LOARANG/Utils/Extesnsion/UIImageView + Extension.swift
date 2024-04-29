//
//  UIImageView + Extension.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ imageUrl: String?, completion: ((UIImage) -> Void)? = nil) {
        guard let url = URL(string: imageUrl ?? "") else {
            return
        }
        let options: KingfisherOptionsInfo = [.cacheMemoryOnly]
        self.kf.setImage(with: url,
                         options: options) { result in
            switch result {
            case .success(let value):
                if let completion = completion {
                    completion(value.image)
                }
            case .failure(_):
                break
            }
        }
    }
}
