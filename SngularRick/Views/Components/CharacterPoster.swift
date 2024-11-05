import SwiftUI

enum CharacterPosterSize {
    case cell
    case detail
}

struct CharacterPoster: View {
    @State private var vm = PosterVM()
    let character: CharacterModel
    var posterSize: CharacterPosterSize = .cell
    
    var body: some View {
        Group {
            if let image = vm.poster {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .frame(maxWidth: posterSize == .cell ? 160 : .infinity)
        .onAppear {
            vm.getImg(character: character)
        }
    }
}

#Preview {
    CharacterPoster(character: .testCharacter)
}
