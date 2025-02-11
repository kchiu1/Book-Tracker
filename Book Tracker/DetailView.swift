import SwiftUI

struct DetailView: View {
    @Binding var title: String
    @Binding var description: String

    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    .frame(height: 40)

                TextField("Title", text: $title)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.leading, 8)
                    .padding(.horizontal, 4)
            }
            .padding(.horizontal)

            TextEditor(text: $description)
                .font(.body)
                .frame(height: 500)
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
