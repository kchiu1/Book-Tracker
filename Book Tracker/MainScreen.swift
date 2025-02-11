import SwiftUI

struct MainScreen: View {
    @State private var books: [Book] = []
    @State private var isAddingBook = false

    var body: some View {
        NavigationView {
            List {
                if books.isEmpty {
                    Text("No Books")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    ForEach($books) { $book in
                        NavigationLink(destination: BookDetailsScreen(book: $book)) {
                            Text(book.title)
                                .font(.body) // Unbolded
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                // Find the index of the book to delete
                                if let index = books.firstIndex(where: { $0.id == book.id }) {
                                    // Remove the book from the list
                                    books.remove(at: index)
                                    // Save the updated books array
                                    Book.saveBooks(books)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
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
            .onAppear {
                // Load books when the view appears
                books = Book.loadBooks()
            }
            .onChange(of: books) { _ in
                // Save books whenever the array changes
                Book.saveBooks(books)
            }
        }
    }
}
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
