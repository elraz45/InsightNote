import SwiftUI

struct NoteCardView: View {
    @ObservedObject var note: Note
    var onEdit: () -> Void
    // Change onColorChange to accept optional Color as well.
    var onColorChange: (Color?) -> Void
    var onSummarize: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.headline)
            Text(note.content)
                .font(.subheadline)
                .lineLimit(2)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(note.color ?? Color(.systemGray6))
                .shadow(radius: 3)
        )
        .frame(maxWidth: .infinity)
        .padding(.horizontal)       // 📏 Padding outside to control spacing
    }
}
