//
//  FavoriteCharactersManager.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 25/01/21.
//

import UIKit


class FavoriteCharactersManager: NSObject {
    
    let favoriteCharactersKey = "favoriteCharacters"
    
    static let shared = FavoriteCharactersManager()
    private override init() {
    }
        
    func add(id: Int) {
        var favorites = getAll()
        favorites.append(id)
        UserDefaults.standard.setValue(favorites, forKey: favoriteCharactersKey)
    }
    
    func delete(id: Int) {
        var favorites = getAll()
        favorites.removeAll(where: { $0 == id })
        UserDefaults.standard.setValue(favorites, forKey: favoriteCharactersKey)
    }
    
    func getAll() -> [Int] {
        return UserDefaults.standard.array(forKey: favoriteCharactersKey) as? [Int] ?? []
    }
    
    func isFavorite(id: Int) -> Bool {
        let favorites = getAll()
        return favorites.contains(id)
    }
    
    func toogleFavorite(id: Int) -> Bool {
        let isFavorite = getAll().contains(id)
        
        if isFavorite {
            delete(id: id)
            NotificationCenter.default.post(name: .characterRemovedFromFavorites, object: id)
            return false
        } else {
            add(id: id)
            return true
        }
    }
    
}

