import SwiftUI

struct BookDetailsScreen: View {
    @ObservedObject var book: Book // Use @ObservedObject to observe the Book
    var onSave: () -> Void // Callback to save the books array

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
                            onSave() // Save the books array after updating
                        }
                    ),
                    showingAddItem: $showingAddItem,
                    itemType: .character,
                    onSave: onSave
                )
            case .event:
                ItemListView(
                    items: Binding(
                        get: { book.items.filter { $0.type == .event } },
                        set: { newItems in
                            book.items = book.items.filter { $0.type != .event } + newItems
                            onSave() // Save the books array after updating
                        }
                    ),
                    showingAddItem: $showingAddItem,
                    itemType: .event,
                    onSave: onSave
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
            AddItemView(book: book, itemType: selectedTab, onSave: onSave)
        }
    }
}
