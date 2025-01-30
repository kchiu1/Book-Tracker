import SwiftUI

struct AddBookScreen: View {
    @Binding var books: [Book]
    @State private var title: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextField("Book Title", text: $title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Spacer()
            }
            .padding()
            .navigationBarItems(trailing: Button("Save") {
                let newBook = Book(title: title)
                books.append(newBook)
                presentationMode.wrappedValue.dismiss()
            }.disabled(title.isEmpty))
        }
    }
}
