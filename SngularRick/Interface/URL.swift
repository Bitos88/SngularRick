import Foundation

let mainURL = URL(string: "https://rickandmortyapi.com/api")!

extension URL {
    static let charactersURL = mainURL.appending(path: "character")
    static let episodesURL = mainURL.appending(path: "episode")
    
    static func getCharacters(page: String, search: String, status: CharacterStatus) -> URL {
        .charactersURL
        .appending(queryItems: [.pageQuery(page: page),
                                .searchQuery(search),
                                .statusQuery(status)])
    }
    
    static func getMultipleEpisodesURL(episodes: String) -> URL {
        .episodesURL.appending(path: episodes)
    }
}

extension URLQueryItem {
    static func pageQuery(page: String) -> URLQueryItem {
        URLQueryItem(name: "page", value: page)
    }
    
    static func searchQuery(_ search: String) -> URLQueryItem {
        URLQueryItem(name: "name", value: search)
    }
    
    static func statusQuery(_ status: CharacterStatus) -> URLQueryItem {
        let statusType: String = switch status {
        case .all: ""
        case .alive: status.rawValue
        case .dead: status.rawValue
        case .unknown: status.rawValue
        }
        
        return URLQueryItem(name: "status", value: statusType)
    }
}
