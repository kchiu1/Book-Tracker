import SwiftUI

struct MainScreen: View {
    @State private var books: [Book] = []
    @State private var isAddingBook = false

    var body: some View {
        NavigationView {
            List {
                ForEach($books) { $book in
                    NavigationLink(destination: BookDetailsScreen(book: $book)) {
                        Text(book.title)
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingBook = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingBook) {
                AddBookScreen(books: $books)
            }
        }
    }

    private func deleteBook(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
