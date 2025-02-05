import SwiftUI

enum ItemType: String, CaseIterable, Identifiable, Codable {
    case character = "Character"
    case event = "Event"

    var id: String { self.rawValue }
    var systemImage: String {
        switch self {
        case .character: return "person.3"
        case .event: return "calendar"
        }
    }
}
