import Foundation

enum CharactersListViewState {
    case loading
    case loaded
    case notFound
    case error
}

@Observable
final class CharactersVM {
    let repository: CharacterRepositoryProtocol
    var characters: [CharacterModel] = []
    var charactersResponse: CharacterResponse?
    var characterStatusFilter: CharacterStatus = .all 
    @ObservationIgnored var page = 1
    var searchText = ""
    
    @ObservationIgnored var searchTask: Task <Void, Never>?
    
    var viewState: CharactersListViewState = .loading
    
    init(repository: CharacterRepositoryProtocol = CharactersRepository()) {
        self.repository = repository
    }
    
    func getCharacters() async {
            do {
                charactersResponse = try await repository.getCharacters(status: characterStatusFilter, page: String(page), searchText: searchText)
                if let response = charactersResponse {
                    characters += response.results
                }
                viewState = .loaded
            } catch {
                if searchText.isEmpty {
                    viewState = .error
                } else {
                    viewState = .notFound
                }
            }
    }
    
    func loadNextPage(character: CharacterModel) {
        guard characters.last?.id == character.id else { return }
        
        if let _ = charactersResponse?.info.next {
            page += 1
            Task(priority: .high) { await getCharacters() }
        }
    }
    
    func loadSearchedCharacters() {
        resetToInitialValues()
        viewState = .loading
        searchTask?.cancel()
        searchTask = nil
        searchTask = Task {
            do {
                try await Task.sleep(for: .milliseconds(600))
                Task(priority: .high) { await getCharacters() }
            } catch {}
        }
    }
    
    func resetToInitialValues() {
        characters.removeAll()
        page = 1
    }
}
