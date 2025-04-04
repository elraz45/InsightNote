import SwiftUI

struct NoteCardView: View {
    let note: Note
    var onEdit: () -> Void
    var onColorChange: (Color) -> Void
    var onSummarize: () -> Void

    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.headline)

            Text(note.content)
                .font(.subheadline)
                .lineLimit(2)

            if let summary = note.summary {
                Text(summary)
                    .font(.caption)
                    .foregroundColor(.blue)
            }

            // HStack {
            //     Button(action: onEdit) {
            //         Image(systemName: "square.and.pencil")
            //     }

            //     Spacer()

            //     Button(action: {
            //         onColorChange(.pink) // just for testing
            //     }) {
            //         Image(systemName: "paintpalette")
            //     }

            //     Spacer()

            //     Button(action: onSummarize) {
            //         Image(systemName: "text.badge.plus")
            //     }
            // }

            // HStack {
            //     ForEach(colors, id: \.self) { color in
            //         Circle()
            //             .fill(color)
            //             .frame(width: 20, height: 20)
            //             .onTapGesture {
            //                 onColorChange(color)
            //             }
            //     }
            // }
        }
        .padding()
        .background(note.color ?? Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
