//
//  Note.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import Foundation
import SwiftUICore

import SwiftUI

struct Note: Identifiable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var dateCreated: Date
    var summary: String?
    var color: Color?

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
                And summarize with AI too!

                Have fun ✨
                """,
                dateCreated: Date()
            )
        ]
    }
}
