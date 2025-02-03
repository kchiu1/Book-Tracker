import Foundation

class Item: Identifiable, ObservableObject, Codable {
    var id = UUID()
    @Published var title: String
    @Published var description: String?
    @Published var type: ItemType

    init(title: String, description: String? = nil, type: ItemType) {
        self.title = title
        self.description = description
        self.type = type
    }

    enum CodingKeys: String, CodingKey {
        case id, title, description, type
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        type = try container.decode(ItemType.self, forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(type, forKey: .type)
    }
}
