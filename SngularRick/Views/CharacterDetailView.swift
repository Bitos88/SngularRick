import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CharacterPoster(character: character, posterSize: .detail)
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                HStack {
                    Circle()
                        .fill(character.status == .alive ? Color.green : Color.red)
                        .frame(width: 12, height: 12)
                    Text(character.status.rawValue.capitalized)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Details")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("Gender:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(character.gender.rawValue.capitalized)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Text("Species:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(character.species)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Text("Created On:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(character.formattedCreated)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    Divider()
                    
                    Text("Episodes")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 8), count: 8), spacing: 8) {
                        ForEach(character.episode.indices, id: \.self) { index in
                            Text(String(index + 1))
                                .font(.subheadline)
                                .frame(width: 40, height: 40)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem {
                ShareLink(item: character.image)
            }
        }
    }
}

#Preview {
    CharacterDetailView(character: .testCharacter)
}
