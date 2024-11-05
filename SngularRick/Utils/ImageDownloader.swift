import SwiftUI

actor ImageDownloader {
    static let shared = ImageDownloader()
    
    private enum ImageStatus {
        case downloading(_ task: Task<UIImage, Error>)
        case downloaded(_ image: UIImage)
    }
    
    private var cache: [URL: ImageStatus] = [:]
    
    func image(from url: URL) async throws -> UIImage {
        if let imageStatus = cache[url] {
            switch imageStatus {
            case .downloading(let task):
                return try await task.value
            case .downloaded(let image):
                return image
            }
        }
        
        let task = Task {
            try await getImage(url: url)
        }
        
        cache[url] = .downloading(task)
        
        do {
            let image = try await task.value
            cache[url] = .downloaded(image)
            try await saveImage(url: url)
            return image
        } catch {
            cache.removeValue(forKey: url)
            throw error
        }
    }
    
    private func getImage(url:URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            return image
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    private func saveImage(url: URL) async throws {
        guard let imageCached = cache[url] else { return }
        let path = url.lastPathComponent
        let cacheDoc = URL.cachesDirectory.appending(path: path)
        if case .downloaded(let image) = imageCached,
           let resize = await image.byPreparingThumbnail(ofSize: image.size),
            let data = resize.heicData() {
            try data.write(to: cacheDoc, options: .atomic)
            cache.removeValue(forKey: url)
        }
    }
}
