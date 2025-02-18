import SwiftUI

struct ItemListView: View {
    @Binding var items: [Item]
    @Binding var showingAddItem: Bool
    var itemType: ItemType
    var onSave: () -> Void // Callback to save the book

    @State private var isEmpty: Bool = false
    @State private var showingImageManager = false

    var body: some View {
        List {
            if items.isEmpty {
                Text(itemType == .character ? "No Characters" : "No Events")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                ForEach(items) { item in
                    NavigationLink(destination: DetailView(
                        title: Binding(
                            get: { item.title },
                            set: { newTitle in
                                if let index = items.firstIndex(where: { $0.id == item.id }) {
                                    items[index].title = newTitle
                                    onSave() // Save the book after editing the title
                                }
                            }
                        ),
                        description: Binding(
                            get: { item.description ?? "" },
                            set: { newDescription in
                                if let index = items.firstIndex(where: { $0.id == item.id }) {
                                    items[index].description = newDescription
                                    onSave() // Save the book after editing the description
                                }
                            }
                        ),
                        images: Binding(
                            get: { item.images },
                            set: { newImages in
                                if let index = items.firstIndex(where: { $0.id == item.id }) {
                                    items[index].images = newImages
                                    onSave() // Save the book after editing the images
                                }
                            }
                        )
                    )) {
                        Text(item.title)
                            .font(.body)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            if let index = items.firstIndex(where: { $0.id == item.id }) {
                                items.remove(at: index)
                                isEmpty = items.isEmpty
                                onSave() // Save the book after deleting the item
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .onChange(of: items) { newItems in
            isEmpty = newItems.isEmpty
        }
        .sheet(isPresented: $showingImageManager) {
            ImageManagerView(images: $items.first?.images ?? .constant([]))
        }
    }
}
