//
//  Book.swift
//  Book Tracker
//
//  Created by Kyle Chiu on 1/30/25.
//


import Foundation

class Book: Identifiable, ObservableObject, Codable {
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
}
