import SwiftUI

struct NoteEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var content: String = ""

    var note: Note?
    var onSave: ((String, String) -> Void)?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                TextEditor(text: $content)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4))
                    )
                    .padding()

                HStack {
                    Button("Cancel") {
                        dismiss()
                    }

                    Spacer()

                    Button("Save") {
                        onSave?(title, content)
                        dismiss()
                    }
                }
                .padding()
            }
            .onAppear {
                if let note = note {
                    title = note.title
                    content = note.content
                }
            }
        }
    }
}
