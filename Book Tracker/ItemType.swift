import SwiftUI

enum ItemType: String, CaseIterable, Identifiable, Codable {
    case character = "Character"
    case event = "Event"
    // Add more types here in the future, e.g.:
    // case location = "Location"
    // case theme = "Theme"

    var id: String { self.rawValue }
    var systemImage: String {
        switch self {
        case .character: return "person.3"
        case .event: return "calendar"
        // Add more cases here for new types
        }
    }
}
