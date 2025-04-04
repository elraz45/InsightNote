import SwiftUI

// Converted to a class so that updates to its properties are published immediately.
class Note: ObservableObject, Identifiable, Equatable {
    let id: UUID
    @Published var title: String
    @Published var content: String
    var dateCreated: Date
    @Published var color: Color?
    
    init(id: UUID = UUID(), title: String, content: String, dateCreated: Date = Date(), color: Color? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.dateCreated = dateCreated
        self.color = color
    }
    
    static func sampleData() -> [Note] {
        return [
                    Note(
                        id: UUID(),
                        title: "👋 Welcome to InsightNote!",
                        content: """
                        This is your very first note 📝
                        
                        You can write anything here — ideas, thoughts, tasks, or even long essays.
                        Tap "New" to create a note.
                        Use "Sort" to organize them.
                        And summarize with AI to rewrite the content!
                        
                        Have fun ✨
                        """,
                        dateCreated: Date(),
                        color: nil
                    )
                ]
    }
    
    static var sample: Note {
         return Note(title: "Sample Note", content: "This is a sample note content.")
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
         return lhs.id == rhs.id
    }
}
