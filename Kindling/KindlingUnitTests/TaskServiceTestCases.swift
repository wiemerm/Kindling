//
//  TaskServiceTestCases.swift
//  KindlingTests
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling
import XCTest

final class TaskServiceTestCases: XCTestCase {
    var mockTaskRepository: MockTaskRepository!
    var mockNetworkRepository: MockNetworkRepository!
    var taskService: DefaultTaskService!

    override func setUpWithError() throws {
        mockTaskRepository = MockTaskRepository()
        mockNetworkRepository = MockNetworkRepository()
        taskService = DefaultTaskService(
            taskRepository: mockTaskRepository,
            networkRepository: mockNetworkRepository
        )
    }

    func test_loadLocalTasks_shouldCallRepository() async throws {
        let expectedTasks = [
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99))
        ]

        mockTaskRepository.tasksToReturn = expectedTasks

        let tasks = try await taskService.loadLocalTasks()

        XCTAssertTrue(mockTaskRepository.loadLocalItemsCallCount == 1)
        XCTAssertEqual(tasks, expectedTasks)
    }

    func test_insertItem_shouldCallRepository() async throws {
        let taskToAdd = ToDo.mock(id: 1)
        _ = try await taskService.insert(taskToAdd)

        XCTAssertEqual(mockTaskRepository.insertCallCount, 1)
        XCTAssertEqual(mockTaskRepository.loadLocalItemsCallCount, 1)
    }

    func test_deleteItem_shouldCallRepository() async throws {
        let taskToDelete = ToDo.mock(id: Int.random(in: 0...99))
        let initialTasks = [
            ToDo.mock(id: Int.random(in: 0...99)),
            taskToDelete,
            ToDo.mock(id: Int.random(in: 0...99))
        ]
        mockTaskRepository.tasksToReturn = initialTasks

        _ = try await taskService.delete(taskToDelete)
        XCTAssertEqual(mockTaskRepository.deleteCallCount, 1)
        XCTAssertEqual(mockTaskRepository.loadLocalItemsCallCount, 1)
    }

    func test_fetchRemoteTasks_shouldCallNetworkRepository() async throws {
        let expectedTasks = [
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99))
        ]

        mockNetworkRepository.tasksToReturn = expectedTasks

        let results = try await taskService.fetchRemoteTasks()

        XCTAssertEqual(mockNetworkRepository.fetchTasksCallCount, 1)
        XCTAssertEqual(mockTaskRepository.insertCallCount, 1)
    }
}
