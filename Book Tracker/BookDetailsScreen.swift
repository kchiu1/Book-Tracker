import SwiftUI

struct BookDetailsScreen: View {
    @Binding var book: Book
    @State private var selectedTab: ItemType = .character
    @State private var showingAddItem = false

    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .character:
                ItemListView(
                    items: Binding(
                        get: { book.items.filter { $0.type == .character } },
                        set: { newItems in
                            book.items = book.items.filter { $0.type != .character } + newItems
                            saveBook()
                        }
                    ),
                    showingAddItem: $showingAddItem,
                    itemType: .character,
                    onSave: saveBook
                )
            case .event:
                ItemListView(
                    items: Binding(
                        get: { book.items.filter { $0.type == .event } },
                        set: { newItems in
                            book.items = book.items.filter { $0.type != .event } + newItems
                            saveBook()
                        }
                    ),
                    showingAddItem: $showingAddItem,
                    itemType: .event,
                    onSave: saveBook
                )
            }

            VStack(spacing: 0) {
                HStack {
                    ForEach(ItemType.allCases) { itemType in
                        Button(action: {
                            selectedTab = itemType
                        }) {
                            VStack {
                                Image(systemName: itemType.systemImage)
                                    .font(.system(size: 20))
                                Text(itemType == .character ? "Characters" : "Events")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == itemType ? .blue : .gray)
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
            }
        }
        .navigationTitle(book.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddItem = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddItem) {
            AddItemView(book: $book, itemType: selectedTab, onSave: saveBook)
        }
    }

    private func saveBook() {
        Book.saveBooks([book])
    }
}
