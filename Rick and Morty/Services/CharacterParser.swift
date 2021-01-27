//
//  CharacterParser.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 27/01/21.
//

import UIKit

class CharacterParser {
    
    static func favoriteParser(data: Data) -> CharacterModel? {
        do {
            let jsonDecoder = JSONDecoder()
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
            let character = try jsonDecoder.decode(CharacterModel.self, from: jsonData)
            return character
        } catch {
            return nil
        }
    }
    
    static func favoritesParser(data: Data) -> [CharacterModel]? {
        do {
            let jsonDecoder = JSONDecoder()
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
            let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
            let character = try jsonDecoder.decode([CharacterModel].self, from: jsonData)
            return character
        } catch {
            return nil
        }
    }
    
    static func listParser(data: Data) -> [CharacterModel]? {
        do {
            let jsonDecoder = JSONDecoder()
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
            let characters = try jsonDecoder.decode(CharacterResultsModel.self, from: jsonData)
            return characters.results
        } catch {
            return nil
        }
    }
    
}

