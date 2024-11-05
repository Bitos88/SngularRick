import Foundation

protocol NetworkRepositoryProtocol {
    var session: URLSession { get }
}

extension NetworkRepositoryProtocol {
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws(NetworkError) -> JSON where JSON: Codable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormat())
        
        let (data, response) = try await session.getData(from: request)
        if response.statusCode == 200 {
            do {
                return try decoder.decode(type, from: data)
            } catch {
                throw .json(error)
            }
        } else {
            throw .status(response.statusCode)
        }
    }
}
