import SwiftUI

struct MainScreen: View {
    @State private var books: [Book] = []
    @State private var isAddingBook = false

    var body: some View {
        NavigationView {
            List {
                ForEach($books) { $book in
                    let bookBinding: Binding<Book> = Binding<Book>(
                        get: { book },
                        set: { newBook in
                            if let index = books.firstIndex(where: { $0.id == book.id }) {
                                books[index] = newBook
                            }
                        }
                    )
                    NavigationLink(destination: BookDetailsScreen(book: bookBinding)) {
                        Text(book.title)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            deleteBook(book)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingBook = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingBook) {
                AddBookScreen(books: $books)
            }
        }
    }

    private func deleteBook(_ book: Book) {
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                books.remove(at: index)
            }
        }
    }

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
