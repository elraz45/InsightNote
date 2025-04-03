//
//  ContentView.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 03/04/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(note.title).font(.headline)
                        Text(note.content).font(.subheadline)
                        if let summary = note.summary {
                            Text(summary).font(.footnote).foregroundColor(.blue)
                        }
                        HStack {
                            Button("Summarize") {
                                viewModel.summarize(note: note)
                            }
                            .buttonStyle(.bordered)

                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("My Notes")
            .toolbar {
                Button("Sort") {
                    viewModel.sortNotesByTitle()
                }
            }
        }
    }
}
