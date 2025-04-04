//
//  NoteDetailView.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import SwiftUI

struct NoteDetailView: View {
    // Use @ObservedObject so that updates to note are reflected immediately
    @ObservedObject var note: Note
    var onEdit: (Note) -> Void
    var onSummarize: (Note) -> Void
    // Change onColorChange to accept an optional Color (nil means default)
    var onColorChange: (Note, Color?) -> Void
    var onUpdate: (Note, String) -> Void   // Called to revert to original content if needed

    @State private var showColorPicker = false
    @State private var isSummarizing = false
    @State private var originalContent: String? = nil

    // Tuple list: display color and actual value (nil means default color)
    private let colorOptions: [(display: Color, value: Color?)] = [
        (display: Color(.systemGray6), value: nil),  // Default color option
        (display: .red, value: .red),
        (display: .blue, value: .blue),
        (display: .green, value: .green),
        (display: .orange, value: .orange),
        (display: .pink, value: .pink),
        (display: .purple, value: .purple)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.title)
                .bold()
            
            ScrollView {
                Text(note.content)
                    .font(.body)
                    .padding(.top, 8)
            }
            
            HStack(spacing: 20) {
                Button(action: {
                    onEdit(note)
                }) {
                    Text("Edit")
                }
                
                Button(action: {
                    if originalContent == nil {
                        originalContent = note.content
                    }
                    isSummarizing = true
                    onSummarize(note)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isSummarizing = false
                    }
                }) {
                    if isSummarizing {
                        ProgressView()
                    } else {
                        Text("Summarize")
                    }
                }
                
                Button(action: {
                    showColorPicker.toggle()
                }) {
                    Text("Color")
                }
                .overlay(
                    Group {
                        if showColorPicker {
                            HStack(spacing: 10) {
                                ForEach(0..<colorOptions.count, id: \.self) { index in
                                    let option = colorOptions[index]
                                    Circle()
                                        .fill(option.display)
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            onColorChange(note, option.value)
                                            showColorPicker = false
                                        }
                                }
                            }
                            .padding(8)
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .shadow(radius: 3)
                            .offset(x: 0, y: -40)
                        }
                    }, alignment: .topTrailing
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 16)
            
            // If originalContent is stored, show a Revert button
            if let original = originalContent {
                Button(action: {
                    onUpdate(note, original)
                    originalContent = nil
                }) {
                    HStack {
                        Image(systemName: "arrow.uturn.backward")
                        Text("Revert")
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding()
    }
}

#Preview {
    // Replace with appropriate sample data for preview
    NoteDetailView(
        note: Note.sample,
        onEdit: { _ in },
        onSummarize: { _ in },
        onColorChange: { _, _ in },
        onUpdate: { _, _ in }
    )
}
