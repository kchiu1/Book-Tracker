import Foundation
import SwiftUI

class Book: Identifiable, ObservableObject, Codable, Equatable {
    var id = UUID()
    @Published var title: String
    @Published var items: [Item] // Single list for all items

    init(title: String, items: [Item] = []) {
        self.title = title
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case id, title, items
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        items = try container.decode([Item].self, forKey: .items)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(items, forKey: .items)
    }

    // Conform to Equatable
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.items == rhs.items
    }

    // Save books to a file
    static func saveBooks(_ books: [Book]) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("books.json")

        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: archiveURL)
        } catch {
            print("Error saving books: \(error)")
        }
    }

    // Load books from a file
    static func loadBooks() -> [Book] {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("books.json")

        do {
            let data = try Data(contentsOf: archiveURL)
            let books = try JSONDecoder().decode([Book].self, from: data)
            return books
        } catch {
            print("Error loading books: \(error)")
            return []
        }
    }
}
