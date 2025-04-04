import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingAddNoteView = false
    @State private var selectedNote: Note?
    @State private var noteForEditing: Note? = nil

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.notes) { note in
                        NoteCardView(
                            note: note,
                            onEdit: {
                                selectedNote = note
                            },
                            onColorChange: { color in
                                viewModel.changeColor(for: note, to: color)
                            },
                            onSummarize: {
                                viewModel.summarize(note: note)
                            }
                        )
                        .onTapGesture {
                            selectedNote = note
                        }
                        .onLongPressGesture {
                            selectedNote = note
                            showingAddNoteView = true
                        }
                    }
                    .onDelete(perform: deleteNotes)
                    .onMove { indices, newOffset in
                        viewModel.notes.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
            }
            .navigationTitle("My Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button("New") {
                            showingAddNoteView = true
                        }
                        Button("Sort") {
                            withAnimation {
                                viewModel.sortNotesByTitle()
                            }
                        }
                    }
                }
            }
            // Sheet for creating a new note
            .sheet(isPresented: $showingAddNoteView) {
                NoteEditorView(note: nil) { title, content in
                    viewModel.addNote(title: title, content: content)
                    showingAddNoteView = false
                }
            }
            // Sheet for viewing note details
            .sheet(item: $selectedNote) { note in
                NoteDetailView(
                    note: note,
                    onEdit: { note in
                        // Close detail view and open editor
                        selectedNote = nil
                        noteForEditing = note
                    },
                    onSummarize: { note in
                        viewModel.summarize(note: note)
                    },
                    onColorChange: { note, color in
                        viewModel.changeColor(for: note, to: color)
                    }
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
            // Sheet for editing an existing note
            .sheet(item: $noteForEditing) { note in
                NoteEditorView(note: note) { title, content in
                    viewModel.updateNote(note, newTitle: title, newContent: content)
                    noteForEditing = nil
                }
            }
        }
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        // Remove the note from viewModel.notes
        viewModel.notes.remove(atOffsets: offsets)
    }
}
