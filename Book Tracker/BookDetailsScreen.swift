import SwiftUI

struct BookDetailsScreen: View {
    @Binding var book: Book
    @State private var selectedTab = 0
    @State private var showingAddCharacter = false
    @State private var showingAddEvent = false

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                CharacterListView(book: $book, showingAddCharacter: $showingAddCharacter)
                    .tabItem {
                        Label("Characters", systemImage: "person.3")
                    }
                    .tag(0)

                EventListView(book: $book, showingAddEvent: $showingAddEvent)
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }
                    .tag(1)
            }
        }
        .navigationTitle(book.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if selectedTab == 0 {
                    Button(action: { showingAddCharacter = true }) {
                        Image(systemName: "plus")
                    }
                } else {
                    Button(action: { showingAddEvent = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddCharacter) {
            AddItemView(book: $book, itemType: .character)
        }
        .sheet(isPresented: $showingAddEvent) {
            AddItemView(book: $book, itemType: .event)
        }
    }
}

struct CharacterListView: View {
    @Binding var book: Book
    @Binding var showingAddCharacter: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(book.characters) { character in
                    VStack(alignment: .leading) {
                        Text(character.title)
                            .font(.headline)
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding()
        }
        .navigationTitle("Characters")
    }
}

struct EventListView: View {
    @Binding var book: Book
    @Binding var showingAddEvent: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(book.events) { event in
                    VStack(alignment: .leading) {
                        Text(event.title)
                            .font(.headline)
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding()
        }
        .navigationTitle("Events")
    }
}
