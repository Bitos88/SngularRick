import SwiftUI

@Observable
final class PosterVM {
    var poster: UIImage?
    
    func getImg(character: CharacterModel) {        
        let docURL = URL.cachesDirectory.appending(path: character.image.lastPathComponent)
        if FileManager.default.fileExists(atPath: docURL.path()) {
            if let data = try? Data(contentsOf: docURL) {
                poster = UIImage(data: data)
            }
        } else {
            Task(priority: .high) {
                await getAsyncImg(character: character)
            }
        }
    }
    
    private func getAsyncImg(character: CharacterModel) async {
        Task {
            do {
                poster = try await ImageDownloader.shared.image(from: character.image)
            } catch {
                debugPrint("Downloading Image Error: \(error.localizedDescription)")
            }
        }
    }
}
