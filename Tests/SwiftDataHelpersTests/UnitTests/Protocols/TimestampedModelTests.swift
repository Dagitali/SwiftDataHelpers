//
//  TimestampedModelTests.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package’s licensing information.

 Abstract:
 A test suite to validate the functionality of `TimestampedModel` extensions.
*/

import Foundation
import SwiftData
import Testing
@testable import SwiftDataHelpers

// MARK: - Fixtures

// A mock `Model`` conforming to `TimestampedModel`.
@Model
private final class MockModel: TimestampedModel {
    // MARK: Properties

    // Keys
    @Attribute(.unique) var id: UUID

    // Required
    var name: String

    // Optional
    var createdAt: Date?
    var updatedAt: Date?

    // MARK: Initialization

    init(
        name: String,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        // Keys
        self.id = UUID()

        // Required
        self.name = name

        // Optional
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Tests

/// A test suite to validate the functionality of `TimestampedModel`
/// extensions.
@Suite("TimestampedModel Tests")
struct TimestampedModelTests {
    // MARK: Protocol

    /// Tests the `updateTimestamps()` method of the `TimestampedModel`
    /// extension, where `updateTimestamps` sets both `createdAt` and
    /// `updatedAt` when `createdAt` is initially `nil`.
    ///
    /// This ensures the protocol properly initializes timestamps when the
    /// model is first updated.
    @Test
    func testUpdateTimestamps_whenCreatedAtIsNil_setsCreatedAtAndUpdatedAt() {
        // Given...
        var model = MockModel(name: "Test Model")

        // When...
        model.updateTimestamps()

        // Then...
        #expect(
            model.createdAt != nil,
            "createdAt should not be nil after updateTimestamps."
        )
        #expect(
            model.updatedAt != nil,
            "updatedAt should not be nil after updateTimestamps."
        )
        #expect(
            model.createdAt == model.updatedAt,
            "createdAt and updatedAt should be equal if the model is newly created."
        )
    }

    /// Tests the `updateTimestamps()` method of the `TimestampedModel`
    /// extension, where `updateTimestamps` updates only `updatedAt` while
    /// keeping `createdAt` unchanged when `createdAt` is already set.
    ///
    /// This ensures the protocol handles updates correctly without altering
    /// the original creation timestamp.
    @Test
    func testUpdateTimestamps_whenCreatedAtIsNotNil_updatesOnlyUpdatedAt() {
        // Given...
        let initialDate = Date(timeIntervalSinceNow: -3600) // 1 hour ago
        var model = MockModel(
            name: "Test Model",
            createdAt: initialDate, updatedAt: initialDate
        )

        // When...
        model.updateTimestamps()

        // Then...
        #expect(
            model.createdAt == initialDate,
            "createdAt should not change after calling updateTimestamps if it is already set."
        )
        #expect(
            model.updatedAt != initialDate,
            "updatedAt should be updated to the current date."
        )
        #expect(
            model.updatedAt! > initialDate,
            "updatedAt should be a later date than the initial date."
        )
    }

    /// Tests the `updateTimestamps()` method of the `TimestampedModel`
    /// extension, where `createdAt` remains constant across multiple calls to
    /// `updateTimestamps` while `updatedAt` is updated each time.
    ///
    /// This ensures the protocol behaves consistently across repeated updates.
    @Test
    func testUpdateTimestamps_multipleUpdates_keepCreatedAtConstant() {
        // Given...
        var model = MockModel(name: "Test Model")

        // When...
        model.updateTimestamps()
        let firstUpdateTime = model.updatedAt

        // Simulate some delay.
        Thread.sleep(forTimeInterval: 0.5)

        // Simulate an update.
        model.updateTimestamps()
        let secondUpdateTime = model.updatedAt

        // Then...
        #expect(
            model.createdAt != nil,
            "createdAt should not be nil after multiple updates."
        )
        #expect(
            model.createdAt == firstUpdateTime,
            "createdAt should remain constant after multiple updates."
        )
        #expect(
            firstUpdateTime != secondUpdateTime,
            "updatedAt should change after subsequent updates."
        )
    }
}
