//
//  NoteDetailView.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note
    var onEdit: (Note) -> Void
    var onSummarize: (Note) -> Void
    var onColorChange: (Note, Color) -> Void

    @State private var showColorPicker = false
    @State private var isSummarizing = false
    private let colorOptions: [Color] = [.red, .blue, .green, .orange, .purple, .yellow, .clear]

    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.title)
                .bold()
            
            Text(note.content)
                .font(.body)
                .padding(.top, 8)
            
            HStack(spacing: 20) {
                Button(action: {
                    onEdit(note)
                }) {
                    Text("Edit")
                }
                
                Button(action: {
                    isSummarizing = true
                    onSummarize(note)
                    // Simulate asynchronous summarization; adjust delay as needed
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
            }
            .padding(.top, 16)
            
            if showColorPicker {
                HStack {
                    ForEach(colorOptions, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                onColorChange(note, color)
                                showColorPicker = false
                            }
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
