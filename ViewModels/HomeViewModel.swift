//
//  HomeViewModel.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    //    •    @Published = tells SwiftUI:
    //          “Whenever this variable changes, update the UI”
    @Published var notes: [Note] = Note.sampleData()

    func sortNotesByTitle() {
        notes.sort { $0.title.lowercased() < $1.title.lowercased() }
    }

    func summarize(note: Note) {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { return }
        // Fake summary for now
        notes[index].summary = "Summary: \(note.content.prefix(30))..."
    }
}
