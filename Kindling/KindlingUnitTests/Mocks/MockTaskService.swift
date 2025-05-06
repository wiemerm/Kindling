//
//  MockTaskService.swift
//  Kindling
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling

class MockTaskService: TaskService {
    enum TestError: Error {
        case errorForTesting(message: String)
    }

    // Call Counts
    private(set) var loadLocalTasksCallCount = 0
    private(set) var insertCallCount = 0
    private(set) var deleteCallCount = 0
    private(set) var fetchRemoteTasksCallCount = 0

    // Return Values
    var tasksToReturn = [ToDo]()
    var errorToReturn: TestError?

    func loadLocalTasks() async throws -> [ToDo] {
        loadLocalTasksCallCount += 1

        if let errorToReturn {
            throw errorToReturn
        }

        return tasksToReturn
    }

    func insert(_ item: ToDo) async throws -> [ToDo] {
        insertCallCount += 1

        if let errorToReturn {
            throw errorToReturn
        }

        tasksToReturn.append(item)

        return tasksToReturn
    }

    func delete(_ item: ToDo) async throws -> [ToDo] {
        deleteCallCount += 1

        if let errorToReturn {
            throw errorToReturn
        }

        tasksToReturn.removeAll(where: { $0.id == item.id })
        return tasksToReturn
    }

    func fetchRemoteTasks() async throws -> [ToDo] {
        fetchRemoteTasksCallCount += 1

        if let errorToReturn {
            throw errorToReturn
        }

        return tasksToReturn
    }
}
