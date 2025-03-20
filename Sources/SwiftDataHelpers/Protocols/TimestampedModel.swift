//
//  TimestampedModel.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package’s licensing information.

 Abstract:
 A protocol for models that require timestamp information for creation and
 updates.
*/

import SwiftUI

// MARK: - Public

/// A protocol for models that require timestamp tracking.
///
/// This protocol defines properties for managing the creation and update
/// timestamps of a model. It can be adopted by models to standardize the
/// handling of these timestamps in your app.
@available(iOS 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public protocol TimestampedModel {
    /// The timestamp when the model was created.
    var createdAt: Date? { get set }

    /// The timestamp when the model was last updated.
    var updatedAt: Date? { get set }
}

// MARK: - Public (Protocol Defaults)

@available(iOS 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public extension TimestampedModel {
    /// Updates the `createdAt` and `updatedAt` timestamps for the model.
    ///
    /// - If `createdAt` is `nil`, it is set to the current date and time.
    /// - `updatedAt` is always updated to the current date and time.
    mutating func updateTimestamps() {
        let now = Date()
        if createdAt == nil { createdAt = now }
        updatedAt = now
    }
}
