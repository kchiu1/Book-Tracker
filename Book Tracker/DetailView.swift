import SwiftUI

struct DetailView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var images: [UIImage] // Binding for images

    @State private var selectedImageIndex: Int = 0
    @State private var showingImageManager = false // State to control sheet presentation

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

            // TextEditor for Description
            TextEditor(text: $description)
                .font(.body)
                .frame(height: images.isEmpty ? 500 : 300) // 500 if no images, 300 if images
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal)

            // Image Carousel (only shown if there are images)
            if !images.isEmpty {
                TabView(selection: $selectedImageIndex) {
                    ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                        if let resizedImage = image.resized(toWidth: 300) { // Resize image to reduce lag
                            Image(uiImage: resizedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(8)
                                .padding(.horizontal)
                                .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default dots
                .frame(height: 250)
                .overlay(
                    // Dots at the bottom
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ForEach(0..<images.count, id: \.self) { index in
                                Circle()
                                    .fill(index == selectedImageIndex ? Color.blue : Color.gray)
                                    .frame(width: 8, height: 8)
                                    .padding(4)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 8)
                    }
                )
            }

            Spacer()
        }
        .padding(.top, 16)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingImageManager = true // Show the ImageManagerView
                }) {
                    Image(systemName: "photo")
                }
            }
        }
        .sheet(isPresented: $showingImageManager) {
            ImageManagerView(images: $images)
        }
    }
}
