import SwiftUI

struct CharacterCell: View {
    let character: CharacterModel
    
    var body: some View {
        VStack(alignment: .leading) {
            CharacterPoster(character: character)
            Text(character.name)
                .font(.title2)
                .lineLimit(1)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CharacterCell(character: .testCharacter)
}
