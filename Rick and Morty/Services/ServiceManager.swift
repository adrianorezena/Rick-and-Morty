//
//  ServiceManager.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 22/01/21.
//

import Foundation

//https://rickandmortyapi.com
class ServiceManager: ServiceBase {
    
    static let shared = ServiceManager()
    private override init() {
    }
    
    private let kAPICharacters: String = "https://rickandmortyapi.com/api/character"
    private let kAPIFavoriteCharacters: String = "https://rickandmortyapi.com/api/character/"
    
    
    func listCharacters(onComplete: @escaping ([CharacterModel]) -> Void) {
        guard let url = URL(string: kAPICharacters) else {
            onComplete([])
            return
        }
        
        queue.async {
            self.makeRequest(url: url) { (response) in
                switch response {
                    case .success(let data):
                        let characters = CharacterParser.listParser(data: data)
                        DispatchQueue.main.async {
                            onComplete(characters ?? [])
                        }
                        
                    case .failure(let error):
                        print("Erro: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            onComplete([])
                        }
                }
            }
        }
    }
    
    
    func getFavoriteCharacters(favorites: [Int], onComplete: @escaping ([CharacterModel]) -> Void) {
        if favorites.count == 0 {
            onComplete([])
            return
        }
        
        let favoriteIDs = favorites.map({ "\($0)" }).joined(separator: ",")
        let stringURL = kAPIFavoriteCharacters + favoriteIDs
        
        guard let url = URL(string: stringURL) else {
            onComplete([])
            return
        }
        
        queue.async {
            self.makeRequest(url: url) { (response) in
                switch response {
                    case .success(let data):
                        if favorites.count == 1 {
                            let character = CharacterParser.favoriteParser(data: data)
                            DispatchQueue.main.async {
                                if let character = character {
                                    onComplete([character])
                                } else {
                                    onComplete([])
                                }
                            }
                        } else {
                            let characters = CharacterParser.favoritesParser(data: data)
                            DispatchQueue.main.async {
                                onComplete(characters ?? [])
                            }
                        }
                        
                    case .failure(let error):
                        print("Erro: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            onComplete([])
                        }
                }
            }
        }
    }
    
}
