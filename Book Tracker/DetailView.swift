//
//  DetailView.swift
//  Book Tracker
//
//  Created by Kyle Chiu on 1/28/25.
//


import SwiftUI

struct DetailView: View {
    @Binding var title: String
    @Binding var description: String

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
        }
        .padding()
        .onDisappear(perform: save)
    }

    private func save() {
        // Save logic can be implemented here if needed
    }
}
