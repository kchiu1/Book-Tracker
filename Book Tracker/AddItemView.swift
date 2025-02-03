import SwiftUI

struct AddItemView: View {
    @Binding var book: Book
    var itemType: ItemType

    @State private var title: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 10) { // Reduced spacing
                TextField("Title", text: $title)
                    .font(.body) // Smaller and unbolded
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Add horizontal padding only

                Spacer()
            }
            .padding(.top, 10) // Add a small top padding
            .navigationTitle("Add \(itemType.rawValue)")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let newItem = Item(title: title, type: itemType)
                    book.items.append(newItem)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
}
