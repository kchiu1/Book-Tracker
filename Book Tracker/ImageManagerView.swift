import SwiftUI
import PhotosUI

struct ImageManagerView: View {
    @Binding var images: [UIImage] // Binding to the images array

    @State private var isImagePickerPresented = false
    @State private var selectedImageToDelete: UIImage? = nil // Track image to delete

    var body: some View {
        VStack {
            // Custom Navigation Bar
            HStack {
                Spacer()

                // Add Image Button (+)
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.trailing)
                }
            }
            .padding(.vertical, 8)
            .background(Color(.systemBackground)) // Match the navigation bar background

            // List of Images
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(images, id: \.self) { image in
                        if let resizedImage = image.resized(toWidth: 200) { // Resize image to reduce lag
                            ZStack {
                                Image(uiImage: resizedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(8)
                                    .opacity(selectedImageToDelete == image ? 0.5 : 1) // Gray out if selected
                                    .overlay(
                                        selectedImageToDelete == image ?
                                        Text("Delete")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(6)
                                            .background(Color.red.opacity(0.8))
                                            .cornerRadius(4)
                                        : nil
                                    )
                            }
                            .onTapGesture {
                                if selectedImageToDelete == image {
                                    // Delete the image
                                    if let index = images.firstIndex(of: image) {
                                        images.remove(at: index)
                                        selectedImageToDelete = nil // Reset selection
                                    }
                                } else {
                                    // Select the image for deletion
                                    selectedImageToDelete = image
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Manage Images")
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImages: $images)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // 0 means no limit

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImages.append(image)
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
}

// Helper function to resize images
extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width / size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
