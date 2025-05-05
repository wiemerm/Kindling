//
//  TaskServiceTestCases.swift
//  KindlingTests
//
//  Created by Megan Wiemer on 5/5/25.
//

@testable import Kindling
import XCTest

final class TaskServiceTestCases: XCTestCase {
    var taskRepository: MockTaskRepository!
    var taskService: DefaultTaskService!

    override func setUpWithError() throws {
        taskRepository = MockTaskRepository()
        taskService = DefaultTaskService(taskRepository: taskRepository)
    }

    func test_loadLocalTasks_shouldCallRepository() async throws {
        let expectedTasks = [
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99)),
            ToDo.mock(id: Int.random(in: 0...99))
        ]

        taskRepository.tasksToReturn = expectedTasks

        let tasks = try await taskService.loadLocalTasks()

        XCTAssertTrue(taskRepository.loadLocalItemsCallCount == 1)
        XCTAssertEqual(tasks, expectedTasks)
    }

    func test_insertItem_shouldCallRepository() async throws {
        let taskToAdd = ToDo.mock(id: 1)
        try await taskService.insert(taskToAdd)

        XCTAssertEqual(taskRepository.insertCallCount, 1)
    }

    func test_deleteItem_shouldCallRepository() async throws {
        let taskToDelete = ToDo.mock(id: Int.random(in: 0...99))
        taskRepository.tasksToReturn = [
            ToDo.mock(id: Int.random(in: 0...99)),
            taskToDelete,
            ToDo.mock(id: Int.random(in: 0...99))
        ]

        try await taskService.delete(taskToDelete)
        XCTAssertEqual(taskRepository.deleteCallCount, 1)
    }
}
