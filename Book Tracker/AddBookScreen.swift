import SwiftUI

struct AddBookScreen: View {
    @Binding var books: [Book]
    @State private var title: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 10) { // Reduced spacing
                TextField("Book Title", text: $title)
                    .font(.body) // Smaller and unbolded
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal) // Add horizontal padding only

                Spacer()
            }
            .padding(.top, 10) // Add a small top padding
            .navigationTitle("Add Book")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let newBook = Book(title: title)
                    books.append(newBook)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
}
