//
//  NSMutableAttributedString.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 25/01/21.
//

import UIKit

extension NSMutableAttributedString {
    
    @discardableResult
    func set(_ text: String, with font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        let normalString = NSMutableAttributedString(string:text, attributes: attrs)
        append(normalString)
        
        return self
    }
    
}
