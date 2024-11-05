import SwiftUI

@main
struct SngularRickApp: App {
    @State var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showSplash {
                    LaunchScreen()
                } else {
                    CharactersListView()
                }
            }
            .onAppear {
                Task {
                    try await Task.sleep(for: .seconds(2))
                    showSplash = false
                }
            }
            .animation(.easeInOut, value: showSplash)
            .preferredColorScheme(.dark)
        }
    }
}
