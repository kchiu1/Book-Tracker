import SwiftUI

struct AddItemView: View {
    @Binding var book: Book
    @State private var title: String = ""
    @State private var description: String = ""

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $description)
                .font(.body)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()

            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)

                Spacer()

                Button(action: addItem) {
                    Text("Add Item")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(title.isEmpty)
            }
            .padding()
        }
        .padding()
    }

    private func addItem() {
        let newItem = Item(title: title, description: description)
        book.items.append(newItem)
        presentationMode.wrappedValue.dismiss()
    }
}
