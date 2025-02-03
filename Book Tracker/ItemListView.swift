import SwiftUI

struct ItemListView: View {
    @Binding var items: [Item]
    @Binding var showingAddItem: Bool
    var itemType: ItemType

    var body: some View {
        List {
            if items.isEmpty {
                Text(itemType == .character ? "No Characters" : "No Events")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                ForEach($items) { $item in
                    NavigationLink(destination: DetailView(title: $item.title, description: Binding(
                        get: { item.description ?? "" },
                        set: { item.description = $0 }
                    ))) {
                        Text(item.title)
                            .font(.body) // Unbolded
                    }
                }
            }
        }
        // Removed the redundant navigation title
    }
}
