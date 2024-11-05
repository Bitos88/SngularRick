import SwiftUI

extension View {
    func mainToolbar(status: Binding<CharacterStatus>) -> some View {
        self.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Picker("", selection: status) {
                        ForEach(CharacterStatus.allCases) { status in
                            Text(status.rawValue)
                        }
                    }
                } label: {
                    Image(systemName: "list.bullet")
                }
                
            }
        }
    }
}

