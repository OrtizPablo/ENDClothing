//
//  UIImageView+Helpers.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 16/06/2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(urlString: String, placeholderImageName: String) {
        sd_setImage(with: URL(string: urlString),
                    placeholderImage: UIImage(named: placeholderImageName),
                    options: .highPriority,
                    context: nil,
                    progress: nil,
                    completed: nil)
    }
}
