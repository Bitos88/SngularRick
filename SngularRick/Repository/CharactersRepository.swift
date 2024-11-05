import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacters(status: CharacterStatus, page: String, searchText: String) async throws(NetworkError) -> CharacterResponse
}

struct CharactersRepository: CharacterRepositoryProtocol, NetworkRepositoryProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCharacters(status: CharacterStatus, page: String, searchText: String) async throws(NetworkError) -> CharacterResponse {
        try await getJSON(request: .get(url: .getCharacters(page: page, search: searchText, status: status)), type: CharactersResponseDTO.self).mapToModel
    }
}
