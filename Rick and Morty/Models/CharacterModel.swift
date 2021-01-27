//
//  CharacterModel.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 23/01/21.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let origin: CharacterLocationModel
    let location: CharacterLocationModel
    let created: String
}
