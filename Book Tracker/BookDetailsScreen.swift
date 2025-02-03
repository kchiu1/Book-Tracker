import SwiftUI

struct BookDetailsScreen: View {
    @Binding var book: Book
    @State private var selectedTab: ItemType = .character
    @State private var showingAddItem = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // Item List View (based on selected tab)
            switch selectedTab {
            case .character:
                ItemListView(
                    items: Binding(
                        get: { book.items.filter { $0.type == .character } },
                        set: { newItems in
                            // Update the items in the book
                            for newItem in newItems {
                                if let index = book.items.firstIndex(where: { $0.id == newItem.id }) {
                                    book.items[index] = newItem
                                }
                            }
                        }
                    ),
                    showingAddItem: $showingAddItem,
                    itemType: .character
                )
            case .event:
                ItemListView(
                    items: Binding(
                        get: { book.items.filter { $0.type == .event } },
                        set: { newItems in
                            // Update the items in the book
                            for newItem in newItems {
                                if let index = book.items.firstIndex(where: { $0.id == newItem.id }) {
                                    book.items[index] = newItem
                                }
                            }
                        }
                    ),
                    showingAddItem: $showingAddItem,
                    itemType: .event
                )
            }

            // Custom Bottom Bar
            VStack(spacing: 0) {
                HStack {
                    ForEach(ItemType.allCases) { itemType in
                        Button(action: {
                            selectedTab = itemType
                        }) {
                            VStack {
                                Image(systemName: itemType.systemImage)
                                    .font(.system(size: 20))
                                Text(itemType == .character ? "Characters" : "Events") // Simplified label
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == itemType ? .blue : .gray)
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground)) // Use system background color
            }
        }
        .navigationTitle(book.title) // Display the book name at the top
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddItem = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddItem) {
            AddItemView(book: $book, itemType: selectedTab)
        }
    }
}
