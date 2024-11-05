import Foundation

enum NetworkError: LocalizedError {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case nonHTTP
    
    var errorDescription: String? {
        switch self {
            case .general(let error):
                "General Error: \(error.localizedDescription)"
            case .status(let int):
                "Status Error: \(int)."
            case .json(let error):
                "JSON Error: \(error)."
            case .dataNotValid:
                "Not valid Data."
            case .nonHTTP:
                "Not an HTTP connection."
        }
    }
}
