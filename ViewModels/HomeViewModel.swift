//
//  HomeViewModel.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var notes: [Note] = Note.sampleData()
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
    }
    
    func updateNote(_ note: Note, newTitle: String, newContent: String) {
        // For a class, we can directly update its properties.
        note.title = newTitle
        note.content = newContent
    }
    
    // Update the note's color; color can be nil for default
    func changeColor(for note: Note, to color: Color?) {
        note.color = color
    }
    
    // The summarize function now updates note.content using AI
    func summarize(note: Note) {
        let openAIService = OpenAIService()
        openAIService.summarize(text: note.content) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rewrittenText):
                    note.content = rewrittenText
                case .failure(let error):
                    print("Error summarizing note: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func sortNotesByDate() {
        notes.sort { $0.dateCreated < $1.dateCreated }
    }
    
    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}
