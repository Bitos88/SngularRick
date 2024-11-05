import Testing
import SwiftUI
@testable import SngularRick

@Suite("ViewModel")
struct SngularRickTests {
    var repository: CharacterRepositoryProtocol
    var viewModel: CharactersVM

    init() {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [NetworkMockInterface.self]
        let session = URLSession(configuration: config)
        
        repository = CharactersRepository(session: session)
        viewModel = CharactersVM(repository: repository)
    }
    
    @Test func givenEmptyData_WhenViewModelInit_ThenFirstPageLoaded() async throws {
        await viewModel.getCharacters()
        #expect(viewModel.characters.count == 20, "It is expected to load 20 characters once the viewModel has initialized.")
    }
    
    @Test func givenFirstPageLoaded_WhenSecondPage_ThenSecondPageLoaded() async throws {
        await viewModel.getCharacters()
        viewModel.page += 1
        await viewModel.getCharacters()
        
        #expect(viewModel.characters.count == 40, "It is expected to load 40 characters once the page is two.")
    }
    
    @Test func givenFirstCharacters_WhenCheckNextPage_ThenPageUp() async throws {
        await viewModel.getCharacters()
        let character = viewModel.characters.last!

        viewModel.loadNextPage(character: character)

        #expect(viewModel.page == 2, "Expected second page after character is the last in array")
    }
    
    @Test func givenSecondPageValues_WhenResetToInitial_ThenInitialValues() async throws {
        await viewModel.getCharacters()
        #expect(viewModel.characters.count == 20, "Expected to load 20 characters from mock Network")
        viewModel.page += 1
        #expect(viewModel.page == 2)
        
        viewModel.resetToInitialValues()
        
        #expect(viewModel.characters.count == 0, "Expected empty array after call method")
        #expect(viewModel.page == 1, "Expected page initial value after call method")
    }
    
    @Test func fetchCharacters_withValidJSON_returnsExpectedResults() async throws {
        let characters = try await repository.getCharacters(status: .all, page: "1", searchText: "").results
        #expect(characters.count == 20, "Expected to load 20 characters from mock JSON data")
    }
    
    @Test func fetchCharacters_withValidJSON_returnsFirstValueExpected() async throws {
        let characters = try await repository.getCharacters(status: .all, page: "1", searchText: "").results
        #expect(characters.first?.name == "Rick Sanchez MOCK", "Expected first character name to be 'Rick Sanchez'")
    }
}

@Suite("Repository")
struct SngularRickRepositoryTests {
    var repository: CharacterRepositoryProtocol

    init() {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [NetworkMockInterface.self]
        let session = URLSession(configuration: config)
        
        repository = CharactersRepository(session: session)
    }
    
    @Test func fetchCharacters_withValidJSON_returnsExpectedResults() async throws {
        let characters = try await repository.getCharacters(status: .all, page: "1", searchText: "").results
        #expect(characters.count == 20, "Expected to load 20 characters from mock JSON data")
    }
    
    @Test func fetchCharacters_withValidJSON_returnsFirstValueExpected() async throws {
        let characters = try await repository.getCharacters(status: .all, page: "1", searchText: "").results
        #expect(characters.first?.name == "Rick Sanchez MOCK", "Expected first character name to be 'Rick Sanchez'")
    }
}
