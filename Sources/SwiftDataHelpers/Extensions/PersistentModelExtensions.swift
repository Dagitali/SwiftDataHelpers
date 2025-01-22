//
//  PersistentModelExtensions.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package’s licensing information.

 Abstract:
 Helper extensions to `PersistentModel`.
*/

import Foundation
import SwiftData

// MARK: - Public (Codable Conformance)

/// An extension for `PersistentModel` types conforming to `Codable`.
public extension PersistentModel where Self: Codable{
    // MARK: Methods

    /// Converts the current instance of the model into JSON data.
    ///
    /// - Returns: A `Data` object containing the JSON representation of the
    ///   model, or `nil` if encoding fails.
    func toJSON() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    // MARK: Static Methods

    /// Creates an instance of the model from JSON data.
    ///
    /// - Parameter data: A `Data` object containing the JSON representation of
    ///   the model.
    /// - Returns: An instance of the model if decoding is successful, or `nil`
    ///   if decoding fails.
    static func fromJSON(_ data: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
