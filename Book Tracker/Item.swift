import SwiftUI
import UIKit

class Item: Identifiable, ObservableObject, Codable, Equatable {
    var id = UUID()
    @Published var title: String
    @Published var description: String?
    @Published var type: ItemType
    @Published var images: [UIImage] = []

    init(title: String, description: String? = nil, type: ItemType, images: [UIImage] = []) {
        self.title = title
        self.description = description
        self.type = type
        self.images = images
    }

    enum CodingKeys: String, CodingKey {
        case id, title, description, type, images
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        type = try container.decode(ItemType.self, forKey: .type)
        
        // Decode images from Data to UIImage
        let imageDataArray = try container.decodeIfPresent([Data].self, forKey: .images) ?? []
        images = imageDataArray.compactMap { UIImage(data: $0) }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(type, forKey: .type)
        
        // Encode images from UIImage to Data
        let imageDataArray = images.compactMap { $0.jpegData(compressionQuality: 1.0) }
        try container.encode(imageDataArray, forKey: .images)
    }

    // Conform to Equatable
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.type == rhs.type &&
               lhs.images == rhs.images
    }
}
