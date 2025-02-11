import SwiftUI
struct AddItemView: View {
    @Binding var book: Book
    var itemType: ItemType
    var onSave: () -> Void // Callback to save the book

    @State private var title: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("Title", text: $title)
                    .font(.body)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 10)
            .navigationTitle("Add \(itemType.rawValue)")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let newItem = Item(title: title, type: itemType)
                    book.items.append(newItem)
                    onSave() // Save the book after adding the item
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
}
