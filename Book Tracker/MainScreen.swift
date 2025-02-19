import SwiftUI

struct MainScreen: View {
    @State private var books: [Book] = []
    @State private var isAddingBook = false

    var body: some View {
        NavigationView {
            bookList
                .navigationTitle("Books")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addBookButton
                    }
                }
                .sheet(isPresented: $isAddingBook) {
                    AddBookScreen(books: $books)
                }
                .onAppear {
                    loadBooks()
                }
                .onChange(of: books) { _ in
                    saveBooks()
                }
        }
    }

    // Book List View
    private var bookList: some View {
        List {
            if books.isEmpty {
                noBooksView
            } else {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailsScreen(book: book, onSave: saveBooks)) {
                        Text(book.title)
                            .font(.body)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        deleteBookButton(for: book)
                    }
                }
            }
        }
    }

    // No Books View
    private var noBooksView: some View {
        Text("No Books")
            .font(.subheadline)
            .foregroundColor(.gray)
    }

    // Add Book Button
    private var addBookButton: some View {
        Button(action: {
            isAddingBook = true
        }) {
            Image(systemName: "plus")
        }
    }

    // Delete Book Button
    private func deleteBookButton(for book: Book) -> some View {
        Button(role: .destructive) {
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                books.remove(at: index)
                saveBooks()
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }

    // Load Books
    private func loadBooks() {
        books = Book.loadBooks()
    }

    // Save Books
    private func saveBooks() {
        Book.saveBooks(books)
    }
}
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
