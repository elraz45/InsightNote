//
//  HomeViewModel.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    //    •    @Published = tells SwiftUI:
    //          “Whenever this variable changes, update the UI”
    
    
    @Published var notes: [Note] = Note.sampleData()

    

    func addNote(title: String, content: String) {
        let newNote = Note(id: UUID(), title: title, content: content, dateCreated: Date())
        notes.append(newNote)
    }

    func updateNote(_ note: Note, newTitle: String, newContent: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = newTitle
            notes[index].content = newContent
        }
    }

    func changeColor(for note: Note, to color: Color) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].color = color
        }
    }

    func summarize(note: Note) {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { return }
        let openAIService = OpenAIService()
        openAIService.summarize(text: note.content) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let summarizedText):
                    self.notes[index].summary = summarizedText
                case .failure(let error):
                    print("Error summarizing note: \(error)")
                }
            }
        }
    }

    func sortNotesByTitle() {
        notes.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
    }
}
