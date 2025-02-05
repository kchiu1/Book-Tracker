import SwiftUI

struct DetailView: View {
    @Binding var title: String
    @Binding var description: String

    var body: some View {
        VStack(spacing: 16) {
            // Title Text Field
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    .frame(height: 40) // Match the height of the TextField

                TextField("Title", text: $title)
                    .font(.system(size: 28, weight: .bold)) // Bigger and bold title
                    .padding(.leading, 8) // Move the text inside the TextField slightly to the right
                    .padding(.horizontal, 4) // Add horizontal padding
            }
            .padding(.horizontal)

            // Description Text Editor
            TextEditor(text: $description)
                .font(.body)
                .frame(height: 500) // Fixed height of 500 pixels
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 16)
    }
}
// Preview
struct DetailView_Previews: PreviewProvider {
    @State static var title = "Sample Title"
    @State static var description = "This is a sample description. It can be very long and will scroll if it exceeds the height of the TextEditor."

    static var previews: some View {
        NavigationView {
            DetailView(title: $title, description: $description)
        }
    }
}
