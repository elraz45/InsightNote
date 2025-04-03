//
//  Note.swift
//  InsightNote
//
//  Created by Elraz Hamtsani on 04/04/2025.
//

import Foundation

struct Note: Identifiable {
    let id: UUID
    var title: String
    var content: String
    var summary: String? = nil
    var dateCreated: Date

    static func sampleData() -> [Note] {
        return [
            Note(id: UUID(), title: "SwiftUI", content: "SwiftUI is Apple’s framework...", dateCreated: Date()),
            Note(id: UUID(), title: "OpenAI", content: "OpenAI provides APIs for AI-based services...", dateCreated: Date())
        ]
    }
}
