import Foundation

final class NetworkMockInterface: URLProtocol {
    var urlTest: URL {
        Bundle.main.url(forResource: "RickMortyMockData", withExtension: "json")!
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let url = request.url {
            if url.lastPathComponent == "character" {
                guard let data = try? Data(contentsOf: urlTest),
                      let response = HTTPURLResponse(url: url,
                                                     statusCode: 200,
                                                     httpVersion: nil,
                                                     headerFields: ["Content-Type": "application/json; charset=utf-8"]) else { return }
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
