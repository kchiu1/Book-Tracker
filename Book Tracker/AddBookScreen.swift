import SwiftUI

struct AddBookScreen: View {
    @Binding var books: [Book]
    @State private var title: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Book Title", text: $title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()

            Button("Add Book") {
                let newBook = Book(title: title)
                books.append(newBook)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(title.isEmpty)
        }
        .padding()
    }
}
