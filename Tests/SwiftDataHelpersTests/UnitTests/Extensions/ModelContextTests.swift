//
//  ModelContextTests.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package’s licensing information.

 Abstract:
 A test suite to validate the functionality of `ModelContext` extensions.
*/

import Foundation
import SwiftData
import Testing
@testable import SwiftDataHelpers

// MARK: - Tests

/// A test suite to validate the functionality of `ModelContext` extensions.
@Suite("ModelContext Tests")
struct ModelContextTests {
    // MARK: SQLLite Tests

    /// Tests the `sqliteCommand` computed  property of the `ModelContext`
    /// extension.
    ///
    /// Verifies that the correct command for a valid SQLite configuration is
    /// returned.
    @Test
    func testSQLiteCommand_ValidConfiguration() async throws {
        // Given...
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        let url = documentsDirectory.appendingPathComponent("testDatabase.sqlite")
        let configuration = ModelConfiguration(url: url)
        let container = try? ModelContainer(configurations: configuration)
        let context = ModelContext(container!)

        // When...
        let expectedCommand = "sqlite3 \"\(url.path)\""

        // Then...
        #expect(
            context.sqliteCommand == expectedCommand,
            "The SQLite command string does not match the expected value."
        )
    }
}
