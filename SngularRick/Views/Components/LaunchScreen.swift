import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        VStack {
            Image(.logoRYM)
                .resizable()
                .scaledToFit()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LaunchScreen()
}
