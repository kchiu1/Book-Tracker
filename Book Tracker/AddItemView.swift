import SwiftUI

enum ItemType {
    case character, event
}

struct AddItemView: View {
    @Binding var book: Book
    var itemType: ItemType
    @State private var title: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .font(.largeTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Spacer()
            }
            .padding()
            .navigationBarItems(trailing: Button("Save") {
                addItem()
            }.disabled(title.isEmpty))
        }
    }

    private func addItem() {
        switch itemType {
        case .character:
            let newCharacter = CharacterItem(title: title)
            book.characters.append(newCharacter)
        case .event:
            let newEvent = EventItem(title: title)
            book.events.append(newEvent)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
