import SwiftUI

struct AddItemView: View {
    @ObservedObject var book: Book // Use @ObservedObject to observe the Book
    var itemType: ItemType
    var onSave: () -> Void // Callback to save the books array

    @State private var title: String = ""
    @State private var isSaving: Bool = false // Track if saving is in progress

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
                    isSaving = true // Disable the button

                    // Trim leading and trailing spaces
                    let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)

                    // Only save if the trimmed title is not empty
                    if !trimmedTitle.isEmpty {
                        let newItem = Item(title: trimmedTitle, type: itemType)
                        book.items.append(newItem)
                        onSave() // Save the books array after adding the item
                    }

                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty || isSaving) // Disable if title is empty or saving is in progress
            )
        }
    }
}
