//
//  InsightNoteTests.swift
//  InsightNoteTests
//
//  Created by Elraz Hamtsani on 03/04/2025.
//

import XCTest
@testable import InsightNote

final class HomeViewModelTests: XCTestCase {

    func test_sortNotesByTitle_shouldSortAlphabetically() {
        let vm = HomeViewModel()
        vm.notes = [
            Note(id: UUID(), title: "Zebra", content: "Z content", dateCreated: Date()),
            Note(id: UUID(), title: "Apple", content: "A content", dateCreated: Date())
        ]
        vm.sortNotesByTitle()
        XCTAssertEqual(vm.notes.first?.title, "Apple")
        XCTAssertEqual(vm.notes.last?.title, "Zebra")
    }

    func test_summarize_shouldSetSummary() {
        let note = Note(id: UUID(), title: "AI", content: "Hello world from GPT!", dateCreated: Date())
        let vm = HomeViewModel()
        vm.notes = [note]
        vm.summarize(note: note)
        XCTAssertNotNil(vm.notes.first?.summary)
        XCTAssertTrue(vm.notes.first!.summary!.starts(with: "Summary"))
    }

}
