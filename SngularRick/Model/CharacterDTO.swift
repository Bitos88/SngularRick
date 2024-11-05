import Foundation

import Foundation

struct CharactersResponseDTO: Codable {
    let info: CharacterResponseInfoDTO
    let results: [CharacterDTO]
    
    var mapToModel: CharacterResponse {
        CharacterResponse(info: info.mapToModel,
                          results: results.map(\.mapToModel))
    }
}

struct CharacterResponseInfoDTO: Codable {
    let next: URL?
    
    var mapToModel: CharacterResponseInfo {
        CharacterResponseInfo(next: next)
    }
}

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let species: String
    let image: URL
    let episode: [URL]
    let created: Date
    
    var mapToModel: CharacterModel {
        CharacterModel(
            id: id,
            name: name,
            status: status,
            gender: gender,
            image: image,
            episode: episode.map(\.lastPathComponent),
            species: species,
            created: created
        )
    }
}

enum CharacterStatus: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Codable {
    var id: Self { self }
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unkown = "unknown"
}
