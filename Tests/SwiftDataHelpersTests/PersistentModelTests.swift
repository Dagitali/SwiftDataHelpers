//
//  PersistentModelTests.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package’s licensing information.

 Abstract:
 A test suite to validate the functionality of `PersistentModel` extensions.
*/

import Foundation
import SwiftData
import Testing
@testable import SwiftDataHelpers

// MARK: - Fixtures

enum CodingKeys: CodingKey {
    case name
}

// A sample `Model`` conforming to `PersistentModel`` and `Codable`.`
@Model
final class SampleModel: Codable {
    // MARK: Properties

    // Keys
    @Attribute(.unique) var id: UUID

    // Required
    var name: String

    // MARK: Initialization

    init(name: String) {
        self.id = UUID()
        self.name = name
    }

    /// A default initializer required by `Decodeable`.
    required init() {
        self.id = UUID()
        self.name = ""
    }

    /// A default initializer required by `Decodeable`.
    required init(from decoder: Decoder) throws {
        self.id = UUID()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    /// A function required by `Encodeable`.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

// MARK: - Tests

/// A test suite to validate the functionality of `PersistentModel` extensions.
@Suite("PersistentModel Tests")
struct PersistentModelTests {
    // MARK: JSON Serialization Tests

    /// Tests the `toJSON()` method of the `PersistentModel` extension.
    ///
    /// Verifies that a model instance can be correctly serialized into JSON
    /// data. Checks that the resulting JSON data is not nil and contains the
    /// expected serialized properties of the model.
    @Test
    func testToJSON() {
        // Arrange
        let sample = SampleModel(name: "Test Model")

        // Act
        let jsonData = sample.toJSON()

        // Assert
        #expect(
            jsonData != nil,
            "JSON data is nil."
        )
        if let jsonData = jsonData {
            let jsonString = String(data: jsonData, encoding: .utf8)
            #expect(
                jsonString != nil,
                "JSON string is nil."
            )
            #expect(
                jsonString?.contains("\"name\":\"Test Model\"") == true,
                "JSON string is nil."
            )
        }
    }

    /// Tests the `fromJSON(_:)` method of the `PersistentModel` extension.
    ///
    /// Verifies that JSON data can be correctly deserialized into a model
    /// instance. Ensures the resulting model has the expected property values.
    @Test
    func testFromJSON() {
        // Arrange
        let jsonString = """
            {
                "id": 1,
                "name": "Test Model"
            }
            """
        let jsonData = jsonString.data(using: .utf8)

        // Act
        let model = SampleModel.fromJSON(jsonData!)

        // Assert
        #expect(
            model != nil,
            "Model is nil."
        )
        if let model = model {
            #expect(
                model.name == "Test Model",
                "Model name is not 'Test Model'."
            )
        }
    }
}
