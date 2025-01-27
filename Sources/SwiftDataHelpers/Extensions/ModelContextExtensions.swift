//
//  ModelContextExtensions.swift
//  SwiftDataHelpers
//
//  Copyright © 2025 Dagitali LLC. All rights reserved.
//

/*
 See the LICENSE.txt file for this package’s licensing information.

 Abstract:
 Helper extensions for reducing SwiftData boilerplate with respect to
 `ModelContext`.

 References:
 1. https://brightdigit.com/tutorials/swiftdata-sendable/
 2. https://fatbobman.com/en/posts/use-core-data-features-in-
    swiftdata-by-swiftdatakit/
 3. https://www.hackingwithswift.com/quick-start/swiftdata/how-to-read-the-
    contents-of-a-swiftdata-database-store
 4. https://keijaoh.com/tutorialdetail/
    SwiftData:%20Delete%20All%20for%20an%20Entity
 5. https://useyourloaf.com/blog/swiftdata-fetching-an-existing-object/
 6. https://useyourloaf.com/blog/swiftdata-saving-changes/
*/

import Foundation
import SwiftData

// MARK: - Public (Computed Properties)

/// An extension for `ModelContext` to provide additional computed properties.
public extension ModelContext {
    // MARK: SQLLite

    /// Generates a command-line string to access the SQLite database
    /// associated with the first configuration of the model container.
    ///
    /// If the `ModelContext` contains a configuration with a valid SQLite
    //  database URL, this property returns the string representation of the
    /// SQLite command to open the database.  Otherwise, it returns a message
    /// indicating no SQLite database was found.
    ///
    /// - Returns: A `String` representing the SQLite command or a "No SQLite
    ///   database found" message.
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}

// MARK: - Public (Functions)

/// An extension for `ModelContext` to provide additional functions.
public extension ModelContext {
    // MARK: Batch Operations

    /// Inserts a batch of persistent model objects into the context and saves
    /// the changes.
    /// - Parameter objects: An array of objects conforming to
    ///   `PersistentModel` to be inserted.
   func insertAll<T: PersistentModel>(_ objects: [T]) {
        objects.forEach { insert($0) }
        saveSafely()
    }

    // MARK: Utilities

    /// Safely saves all pending changes to the model context.
    ///
    /// Attempts to persist all modifications made within the current
    /// `ModelContext` to the underlying storage. Logs any errors that occur
    /// during the save operation.
    ///
    /// ## Example
    /// ```swift
    /// let context = ModelContext()
    /// let newItem = MyModel()
    /// newItem.name = "New Item"
    /// context.insert(newItem)
    ///
    /// context.saveSafely() // Persist the changes
    /// ```
    ///
    /// - Note: If no changes are present in the context, this method has no
    ///   effect.
    func saveSafely() {
        do {
            try save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}
