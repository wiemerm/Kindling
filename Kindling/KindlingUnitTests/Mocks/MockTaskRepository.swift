//
//  MockTaskRepository.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling

class MockTaskRepository: TaskRepository {
    // Call Counts
    private(set) var loadLocalItemsCallCount = 0
    private(set) var insertCallCount = 0
    private(set) var deleteCallCount = 0

    // Return Values
    var tasksToReturn = [ToDo]()

    func loadLocalItems() async throws -> [ToDo] {
        loadLocalItemsCallCount += 1
        return tasksToReturn
    }

    func insert(_ items: [ToDo]) async throws {
        insertCallCount += 1
    }

    func delete(_ item: ToDo) async throws {
        deleteCallCount += 1
    }
}
