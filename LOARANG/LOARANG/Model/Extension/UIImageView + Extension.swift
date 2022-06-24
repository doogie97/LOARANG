//
//  UIImageView + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/24.
//

import UIKit
extension UIImageView {
    func setImage(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let dataTask = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
