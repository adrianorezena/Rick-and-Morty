//
//  Rick_and_MortyTests.swift
//  Rick and MortyTests
//
//  Created by Adriano Rezena on 22/01/21.
//

import XCTest
@testable import Rick_and_Morty

class ParserTests: XCTestCase {
    
    let favoriteCharacter = "{\"id\":1,\"name\":\"Rick Sanchez\",\"status\":\"Alive\",\"species\":\"Human\",\"type\":\"\",\"gender\":\"Male\",\"origin\":{\"name\":\"Earth (C-137)\",\"url\":\"https://rickandmortyapi.com/api/location/1\"},\"location\":{\"name\":\"Earth (Replacement Dimension)\",\"url\":\"https://rickandmortyapi.com/api/location/20\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/1.jpeg\",\"url\":\"https://rickandmortyapi.com/api/character/1\",\"created\":\"2017-11-04T18:48:46.250Z\"}"
    
    let favoriteCharacters = "[{\"id\":1,\"name\":\"Rick Sanchez\",\"status\":\"Alive\",\"species\":\"Human\",\"type\":\"\",\"gender\":\"Male\",\"origin\":{\"name\":\"Earth (C-137)\",\"url\":\"https://rickandmortyapi.com/api/location/1\"},\"location\":{\"name\":\"Earth (Replacement Dimension)\",\"url\":\"https://rickandmortyapi.com/api/location/20\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/1.jpeg\",\"url\":\"https://rickandmortyapi.com/api/character/1\",\"created\":\"2017-11-04T18:48:46.250Z\"},{\"id\":2,\"name\":\"Morty Smith\",\"status\":\"Alive\",\"species\":\"Human\",\"type\":\"\",\"gender\":\"Male\",\"origin\":{\"name\":\"Earth (C-137)\",\"url\":\"https://rickandmortyapi.com/api/location/1\"},\"location\":{\"name\":\"Earth (Replacement Dimension)\",\"url\":\"https://rickandmortyapi.com/api/location/20\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/2.jpeg\",\"url\":\"https://rickandmortyapi.com/api/character/2\",\"created\":\"2017-11-04T18:50:21.651Z\"}]"
    
    let listCharacters = "{\"info\":{\"count\":671,\"pages\":34,\"next\":\"https://rickandmortyapi.com/api/character?page=2\",\"prev\":null},\"results\":[{\"id\":1,\"name\":\"Rick Sanchez\",\"status\":\"Alive\",\"species\":\"Human\",\"type\":\"\",\"gender\":\"Male\",\"origin\":{\"name\":\"Earth (C-137)\",\"url\":\"https://rickandmortyapi.com/api/location/1\"},\"location\":{\"name\":\"Earth (Replacement Dimension)\",\"url\":\"https://rickandmortyapi.com/api/location/20\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/1.jpeg\",\"episode\":[],\"url\":\"https://rickandmortyapi.com/api/character/1\",\"created\":\"2017-11-04T18:48:46.250Z\"},{\"id\":2,\"name\":\"Morty Smith\",\"status\":\"Alive\",\"species\":\"Human\",\"type\":\"\",\"gender\":\"Male\",\"origin\":{\"name\":\"Earth (C-137)\",\"url\":\"https://rickandmortyapi.com/api/location/1\"},\"location\":{\"name\":\"Earth (Replacement Dimension)\",\"url\":\"https://rickandmortyapi.com/api/location/20\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/2.jpeg\",\"episode\":[],\"url\":\"https://rickandmortyapi.com/api/character/2\",\"created\":\"2017-11-04T18:50:21.651Z\"},{\"id\":3,\"name\":\"Summer Smith\",\"status\":\"Alive\",\"species\":\"Human\",\"type\":\"\",\"gender\":\"Female\",\"origin\":{\"name\":\"Earth (Replacement Dimension)\",\"url\":\"https://rickandmortyapi.com/api/location/20\"},\"location\":{\"name\":\"Earth (Replacement Dimension)\",\"url\":\"https://rickandmortyapi.com/api/location/20\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/3.jpeg\",\"episode\":[],\"url\":\"https://rickandmortyapi.com/api/character/3\",\"created\":\"2017-11-04T19:09:56.428Z\"}]}"
    
    
    func testListCharactersParser() throws {
        let data = listCharacters.data(using: .utf8)!
        let characters = CharacterParser.listParser(data: data)
        
        XCTAssert(characters != nil)
    }
    
    
    func testFavoriteCharactersParser() throws {
        let data = favoriteCharacters.data(using: .utf8)!
        let characters = CharacterParser.favoritesParser(data: data)
        
        XCTAssert(characters != nil)
    }
    
    
    func testFavoriteCharacterParser() throws {
        let data = favoriteCharacter.data(using: .utf8)!
        let character = CharacterParser.favoriteParser(data: data)
        
        XCTAssert(character != nil)
    }
    
}

class RequestTests: XCTestCase {
    
    func testCharactersCountRequest() throws {
        let expectation = XCTestExpectation.init(description: "Your expectation")
        
        ServiceManager.shared.listCharacters { (characters) in
            if characters.count != 20 {
                XCTFail("Number of items is not 20")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20)
    }
    
    
    func testFavoriteCharactersRequest() throws {
        let expectation = XCTestExpectation.init(description: "Your expectation")
        
        ServiceManager.shared.getFavoriteCharacters(favorites: [1, 2]) { (characters) in
            if characters.count != 2 {
                XCTFail("Number of items is not 2")
            }
            
            if characters[0].name != "Rick Sanchez" {
                XCTFail("First character is not Rick Sanchez")
            }
            
            if characters[1].name != "Morty Smith" {
                XCTFail("First character is not Morty Smith")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20)
    }
    
}
