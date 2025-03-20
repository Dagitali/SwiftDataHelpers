//
//  ModelContainerExtensions.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package's licensing information.

 Abstract:
 Helper extensions for reducing SwiftData boilerplate with respect to
 `ModelContainer`.

 References:
 1. https://www.hackingwithswift.com/quick-start/swiftdata/how-to-create-a-
    complex-migration-using-versionedschema
*/

import SwiftData

// MARK: - Public Static

/// An extension for `ModelContainer`.to provide additional functions.
@available(iOS 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public extension ModelContainer {
    // MARKL Main Actors

    /// Creates a default `ModelContainer` with optional in-memory storage.
    /// - Parameters:
    ///   - schema: The schema to register with the container.
    ///   - inMemory: Whether the container should use in-memory storage.
    /// - Returns: A configured `ModelContainer` or throws an error if
    ///   initialization fails.
    @MainActor static func defaultContainer(
        for schema: Schema,
        inMemory: Bool = false
    ) -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)

        do {
            return try ModelContainer(
                for: schema,
                configurations: [configuration]
            )
        } catch {
            fatalError("Failed to initialize model container: \(error.localizedDescription).")
        }
    }

    /// Preloads data into the ModelContainer for testing or previews.
    /// - Parameters:
    ///   - models: The models to register.
    ///   - data: The data to preload.
    ///   - inMemory: Whether the container should use in-memory storage.
    /// - Returns: A configured ModelContainer with preloaded data.
    @MainActor static func preloadedContainer(
        for models: Schema,
        data: [any PersistentModel],
        inMemory: Bool = true
    ) -> ModelContainer {
        let container = defaultContainer(for: models, inMemory: inMemory)
        let context = container.mainContext

        data.forEach { context.insert($0) }
        context.saveSafely()

        return container
    }
}
