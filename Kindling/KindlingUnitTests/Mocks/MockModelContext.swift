//
//  MockModelContext.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling
import SwiftData

class MockModelContext: ModelContextProtocol {
    // Call Counters
    private(set) var fetchCallCount = 0
    private(set) var insertCallCount = 0
    private(set) var deleteCallCount = 0
    private(set) var saveCallCount = 0

    // Mock Returns
    var tasksToReturn: [ToDo] = []

    func fetch<T>(_ fetchDescriptor: FetchDescriptor<T>) throws -> [T] where T: PersistentModel {
        fetchCallCount += 1
        return tasksToReturn as? [T] ?? []
    }

    func insert<T>(_ model: T) where T: PersistentModel {
        insertCallCount += 1
    }

    func delete<T>(_ model: T) where T: PersistentModel {
        deleteCallCount += 1
    }

    func save() throws {
        saveCallCount += 1
    }
}
