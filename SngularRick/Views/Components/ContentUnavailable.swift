import SwiftUI

struct NotFoundView: View {
    let searchText: String
    
    var body: some View {
        ContentUnavailableView {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                        .font(.largeTitle)
                        .padding(.bottom, 8)
                    
                    Text("No results for \"\(searchText)\"")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Check the spelling or try a new search.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .shadow(radius: 3, x: 4, y: 4)
                }
            }
            .padding(.bottom, 120)
        }
    }
}


#Preview {
    NotFoundView(searchText: "Rick")
}
