//
//  FavoriteButton.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 27/01/21.
//

import UIKit

@objc protocol FavoriteButtonDelegate {
    @objc optional func onFavoriteButtonClick(characterID: Int, isFavorite: Bool)
}


class FavoriteButton: BaseButton {
    
    var isFavorite: Bool = false {
        didSet {
            tintColor = isFavorite ? .red : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commomInit()
    }
    
    
    private func commomInit() {
        setImage(UIImage(named: Assets.Icons.tabbar_favorites)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
}

