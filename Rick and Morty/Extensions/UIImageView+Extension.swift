//
//  UIImageView+setImage.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 22/01/21.
//

import UIKit
import Kingfisher

extension UIImageView {
        
    public func setImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.1))], progressBlock: nil) { (result) in
        }
    }
    
}

