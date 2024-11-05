import Foundation

struct PreviewCharactersRepository: CharacterRepositoryProtocol {
    func getCharacters(status: CharacterStatus, page: String, searchText: String) async throws(NetworkError) -> CharacterResponse {
        guard let url = Bundle.main.url(forResource: "RickMortyMockData", withExtension: "json") else { return .previewResponse }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.dateFormat())
            return try decoder.decode(CharactersResponseDTO.self, from: data).mapToModel
        } catch {
            throw .dataNotValid
        }
    }
}

extension CharactersVM {
    static let previewVM = CharactersVM(repository: PreviewCharactersRepository())
}

extension CharacterModel {
    static let testCharacter = CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        gender: .male,
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        episode: [],
        species: "Human",
        created: .now
    )
}

extension CharacterResponse {
    static let previewResponse = CharacterResponse(info: CharacterResponseInfo(next: nil), results: [])
}
