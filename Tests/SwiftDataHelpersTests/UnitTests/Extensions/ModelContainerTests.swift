//
//  ModelContainerTests.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package’s licensing information.

 Abstract:
 A test suite to validate the functionality of `ModelContainer` extensions.
*/

import Foundation
import SwiftData
import Testing
@testable import SwiftDataHelpers

// MARK: - Fixtures

// A mock `Model`.
@Model
private final class MockModel {
    // MARK: Properties

    // Keys
    @Attribute(.unique) var id: UUID

    // Required
    var name: String

    // MARK: Initialization

    init(
        name: String
    ) {
        // Keys
        self.id = UUID()

        // Required
        self.name = name
    }
}

// MARK: - Tests

/// A test suite to validate the functionality of `ModelContainer` extensions.
@Suite("ModelContainer Tests")
struct ModelContainerTests {
    // MARK: Main Actors Tests

    /// Tests the creation of a default `ModelContainer` using in-memory
    /// storage.
    ///
    /// Verifies:
    /// - The container is not nil.
    /// - The container uses in-memory storage.
    @Test
    func testDefaultContainer_Creation() async throws {
        // Given...
        let schema = Schema([MockModel.self])

        // When...
        let container = await ModelContainer.defaultContainer(for: schema, inMemory: true)

        // Then...
        #expect(
            container != nil,
            "ModelContainer should not be nil."
        )
    }

    /// Tests the creation of a preloaded ModelContainer with in-memory
    /// storage.
    ///
    /// Verifies:
    /// - The container is not nil.
    /// - The container uses in-memory storage.
    /// - The preloaded data is correctly inserted into the container.
    @MainActor @Test
    func testPreloadedContainerWithInMemoryStorage() {
        // Given...
       let schema = Schema([MockModel.self])
        let mockData = [
            MockModel(name: "Test Item 1"),
            MockModel(name: "Test Item 2")
        ]

        // When...
        let container = ModelContainer.preloadedContainer(for: schema, data: mockData, inMemory: true)

        // Verify data was preloaded.
        let fetchRequest = FetchDescriptor<MockModel>()
        let results = try? container.mainContext.fetch(fetchRequest)

        // Then...
        #expect(
            container != nil,
            "ModelContainer should not be nil."
        )
        #expect(
            results?.count == mockData.count,
            "Container should contain the correct number of preloaded items."
        )
        #expect(
            results?.map(\.name).sorted() == mockData.map(\.name).sorted(),
            "Preloaded data should match the provided data."
        )
    }
}
