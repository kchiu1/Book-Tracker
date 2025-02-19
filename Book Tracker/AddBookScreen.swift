import SwiftUI

struct AddBookScreen: View {
    @Binding var books: [Book]
    @State private var title: String = ""
    @State private var isSaving: Bool = false // Track if saving is in progress

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("Book Title", text: $title)
                    .font(.body)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 10)
            .navigationTitle("Add Book")
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
                        let newBook = Book(title: trimmedTitle)
                        books.append(newBook)
                    }

                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty || isSaving) // Disable if title is empty or saving is in progress
            )
        }
    }
}
