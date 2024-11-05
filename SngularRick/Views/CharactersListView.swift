import SwiftUI

struct CharactersListView: View {
    @State var vm = CharactersVM()
    @Namespace private var detailTransition
    private let gridItem = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            VStack {
                switch vm.viewState {
                case .loading:
                    loadingView
                case .loaded:
                    gridSearch
                case .notFound:
                    NotFoundView(searchText: vm.searchText)
                case .error:
                    CustomErrorView(errorTitle: "UPS... Something went wrong",
                                    errorMessage: "We couldn't retrieve the data. Please check your internet connection and try again later.") {
                        Task(priority: .high) { await vm.getCharacters() }
                    }
                }
            }
            .task(priority: .high) {
                if vm.characters.isEmpty {
                    await vm.getCharacters() 
                }
            }
            .navigationDestination(for: CharacterModel.self) { character in
                CharacterDetailView(character: character)
                    .navigationTransition(.zoom(sourceID: character, in: detailTransition))
            }
            .navigationTitle("Rick & Morty")
            .mainToolbar(status: $vm.characterStatusFilter)
            .onChange(of: vm.characterStatusFilter) {
                vm.resetToInitialValues()
                Task(priority: .high) { await vm.getCharacters() }
            }
            .searchable(text: $vm.searchText,
                        placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: vm.searchText) {
                vm.loadSearchedCharacters()
            }
            .animation(.easeInOut, value: vm.viewState)
            .animation(.easeInOut, value: vm.characterStatusFilter)
        }
    }
    
    var gridSearch: some View {
        ScrollView {
            LazyVGrid(columns: gridItem) {
                ForEach(vm.characters) { character in
                    NavigationLink(value: character) {
                        CharacterCell(character: character)
                            .onAppear {
                                vm.loadNextPage(character: character)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    var loadingView: some View {
        VStack {
            Text("Loading Rick & Morty Characters")
                .font(.title2)
            ProgressView()
                .controlSize(.regular)
        }
    }
}

#Preview {
    CharactersListView(vm: .previewVM)
}
