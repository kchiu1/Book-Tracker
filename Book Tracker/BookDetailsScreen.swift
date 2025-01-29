import SwiftUI

struct BookDetailsScreen: View {
    @Binding var book: Book

    @State private var showingAddItemScreen = false

    var body: some View {
        List {
            ForEach(groupedItems(), id: \.key) { key, items in
                Section(header: Text(key)) {
                    ForEach(items) { item in
                        NavigationLink(destination: detailView(for: item)) {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.description ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(book.title)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddItemScreen = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddItemScreen) {
            AddItemView(book: $book)
        }
    }

    private func groupedItems() -> [String: [Item]] {
        Dictionary(grouping: book.items, by: { item in
            if item.title.contains("Character") {
                return "Characters"
            } else if item.title.contains("Event") {
                return "Events"
            } else {
                return "Others"
            }
        })
    }

    private func updateItem(_ item: Item, with newValue: String, for keyPath: WritableKeyPath<Item, String?>) {
        if let index = book.items.firstIndex(where: { $0.id == item.id }) {
            book.items[index][keyPath: keyPath] = newValue
        }
    }

    private func detailView(for item: Item) -> some View {
        let titleBinding = Binding(
            get: { item.title },
            set: { newValue in updateItem(item, with: newValue, for: \.title) }
        )
        let descriptionBinding = Binding(
            get: { item.description ?? "" },
            set: { newValue in updateItem(item, with: newValue, for: \.description) }
        )
        return DetailView(title: titleBinding, description: descriptionBinding)
    }
}
