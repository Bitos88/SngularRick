import Foundation

struct CharacterResponse {
    let info: CharacterResponseInfo
    let results: [CharacterModel]
}

struct CharacterResponseInfo {
    let next: URL?
}

struct CharacterModel: Identifiable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let image: URL
    let episode: [String]
    let species: String
    let created: Date
    
    var formattedCreated: String {
        created.formatted(date: .complete, time: .omitted)
    }
}
